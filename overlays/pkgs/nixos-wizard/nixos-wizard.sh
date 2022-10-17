efi=""
luks=""
disk=""
format=""
swap=""
configuration=""
username=""
role=""
install=""

#Define the help function
function help()
{
	echo "Options:"
	echo "--efi             Use EFI boot"
	echo "--bios            Use BIOS boot"
	echo "--luks            Encrypt root partition"
	echo "--no-luks         Do not encrypt root partition"
	echo "--disk            Disk device to use"
	echo "--format          Format the disk"
	echo "--no-format       Do not format the disk"
	echo "--swap            Use swap"
	echo "--no-swap         Do not use swap"
	echo "--configuration   Name of configuration to use"
	echo "--username        Admin username"
	echo "--role            Configuration role"
	echo "--install         Perform the installation"
	echo "--help            Show this help list"
}

#Define the getopts variables
options=":--efi:--bios:--luks:--no-luks:--disk:--format:--no-format:--swap:--no-swap:--configuration:--username:--role:--install:--help"

#Start the getopts code
while getopts "$options" opt; do
	case $opt in
		--efi) efi=true ;;
		--bios) efi=false ;;
		--luks) luks=true ;;
		--no-luks) luks=false ;;
		--disk) disk=$OPTARG ;;
		--format) format=true;;
		--no-format) format=false ;;
		--swap) swap=true ;;
		--no-swap) swap=false ;;
		--configuration) configuration=$OPTARG ;;
		--username) username=$OPTARG ;;
		--role) role=$OPTARG ;;
		--install) install=true ;;
		--help)
			help
			exit
		;;
		\?)
			error "Invalid option"
			help
			exit 1
		;;
	esac
done

#This tells getopts to move on to the next argument.
shift $((OPTIND-1))
#End getopts code

ensure_root "$@"
ensure_tmux nixos-wizard "$@"

shopt -s lastpipe

function ensure_flakes()
{
	if nix flake metadata nixpkgs &>/dev/null; then
		return
	fi
	mkdir -p ~/.config/nix
	if ! grep -q flakes ~/.config/nix/nix.conf; then
		echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
	fi
}

ensure_flakes

EFI_LABEL=EFI
LUKS_LABEL=LUKS
NIXOS_LABEL=NixOS
LUKS_DEVICE=/dev/disk/by-partlabel/$LUKS_LABEL
LUKS_NAME=cryptroot
LUKS_OPEN_DEVICE=/dev/mapper/$LUKS_NAME
NIXOS_DEVICE=/dev/disk/by-label/$NIXOS_LABEL
EFI_DEVICE=/dev/disk/by-partlabel/$EFI_LABEL
ROOT_MOUNT=/mnt
ROOT_VOL=$ROOT_MOUNT/root
BOOT_VOL=$ROOT_MOUNT/boot
HOME_VOL=$ROOT_MOUNT/home
SWAP_VOL=$ROOT_MOUNT/swap
SWAP_FILE=$SWAP_VOL/swapfile
NIXOS_DIR=$ROOT_MOUNT/etc/nixos

function luks_open()
{
	if [ -b $LUKS_DEVICE ] && ! [ -b $LUKS_OPEN_DEVICE ]; then
		peval cryptsetup luksOpen $LUKS_DEVICE $LUKS_NAME
	fi
}

function luks_close()
{
	if [ -b $LUKS_OPEN_DEVICE ]; then
		peval cryptsetup close $LUKS_NAME
	fi
}

function is_swapped()
{
	grep -q $SWAP_VOL /proc/swaps
}

function unmount_all()
{
	if is_swapped; then peval swapoff $SWAP_FILE; fi
	maybe_unmount $BOOT_VOL
	maybe_unmount $HOME_VOL
	maybe_unmount $SWAP_VOL
	maybe_unmount $ROOT_MOUNT
	luks_close
}

function mount_all()
{
	if "$efi"; then
		maybe_mount $EFI_DEVICE $BOOT_VOL
	fi
	if "$luks"; then
		luks_open
	fi
	maybe_mount -o subvol=root,compress=zstd $NIXOS_DEVICE $ROOT_MOUNT
	maybe_mount -o subvol=home,compress=zstd $NIXOS_DEVICE $HOME_VOL
	maybe_mount -o subvol=swap $NIXOS_DEVICE $SWAP_VOL
	if [ -f $SWAP_FILE ] && ! is_swapped; then
		peval swapon $SWAP_FILE
	fi
}

function is_efi()
{
	[ -d /sys/firmware/efi ]
}

answer=n
if ! [ -b $NIXOS_DEVICE ]; then
	answer=y
fi
if ask "Create fresh partitions?" "$answer" "$format"; then
	unmount_all
	if [ -z "$disk" ]; then
		disks=()
		lsblk --noheadings --list --paths | grep disk | awk '{print $1,$4,$6,$7}' | while read -r line; do
			disks+=("$line")
		done
		if [ ${#disks[@]} -lt 1 ]; then
			fatal "error: no disks found!"
		elif [ ${#disks[@]} -eq 1 ]; then
			disk=${disks[0]}
			warn 'Only one disk found, using it by default'
		else
			select disk in "${disks[@]}"; do
				if [ -n "$disk" ]; then break; fi
			done
		fi
		disk=$(echo "$disk" | awk '{print $1}')
	fi
	if ! [ -b "$disk" ]; then
		fatal "error: cannot find disk: $disk"
	fi
	info "Selected disk: $disk"
	if [ -z "$efi" ]; then
		if is_efi; then
			select mode in "UEFI BIOS"; do break; done
			if [ "$mode" = UEFI ]; then
				efi=true
			fi
		else
			warn 'System does not support UEFI boot, defaulting to BIOS'
		fi
	fi
	if "$efi" && ! is_efi; then
		fatal 'System does not support UEFI boot'
	fi
	if ask "Encrypt data partition?" n "$luks"; then
		luks=true
		rootLabel=$LUKS_LABEL
	else
		rootLabel=$NIXOS_LABEL
	fi
	p=0
	peval sgdisk --zap-all -o "$disk"
	if "$efi"; then
		peval sgdisk -n "$p:0:+1G" -t "$p:EF00" -c 1:$EFI_LABEL "$disk"
		p=$((p + 1))
	fi
	peval sgdisk -n "$p:0:0" -t "$p:8300" -c "1:$rootLabel" "$disk"
	p=$((p + 1))
	peval partprobe
	if "$luks"; then
		peval cryptsetup luksFormat $LUKS_DEVICE
		luks_open
		peval mkfs.btrfs -f -L $NIXOS_LABEL /dev/mapper/$LUKS_NAME
	else
		peval mkfs.btrfs -f -L $NIXOS_LABEL /dev/disk/by-partlabel/$NIXOS_LABEL
	fi
	if "$efi"; then
		peval mkfs.fat -F32 -n $EFI_LABEL $EFI_DEVICE
	fi
	peval partprobe
	peval mount $NIXOS_DEVICE $ROOT_MOUNT
	peval btrfs subvolume create $ROOT_VOL
	peval btrfs subvolume create $HOME_VOL
	peval btrfs subvolume create $SWAP_VOL
	peval umount $ROOT_MOUNT
	mount_all
	if ask "Create swap file?" y "$swap"; then
		peval touch $SWAP_FILE
		peval chmod 600 $SWAP_FILE
		peval chattr +C $SWAP_FILE
		peval fallocate $SWAP_FILE -l4g
		peval mkswap $SWAP_FILE
		peval swapon $SWAP_FILE
	fi
fi

if ! is_mounted $ROOT_MOUNT && ask "Mount partitions?" y "$install"; then mount_all; fi

function validate_configuration_name()
{
	[[ "$configuration" =~ ^[A-Za-z][A-Za-z0-9-]*$ ]]
}

function validate_username()
{
	[[ "$username" =~ ^[A-Za-z][A-Za-z0-9]*$ ]]
}

function create_new_configuration()
{
	if [ -z "$configuration" ]; then
		while : ; do
			echo -n "Enter new configuration name: "
			read -r configuration
			if validate_configuration_name; then
				break
			fi
			error Invalid configuration name
		done
	elif ! validate_configuration_name; then
		fatal 'Invalid configuration name'
	fi
	configurationDir=$NIXOS_DIR/configurations/$configuration
	if [ -d "$configurationDir" ]; then return; fi
	if [ -z "$username" ]; then
		while : ; do
			echo -n "Enter admin user name (ners): "
			read -r username
			if [ -z "$username" ]; then
				username=ners
			fi
			if validate_username; then
				break
			fi
			error Invalid username
		done
	elif ! validate_username; then
		fatal 'Invalid admin username'
	fi
	if [ "$username" = ners ]; then
		userProfile=self.nixosProfiles.users.ners
	else
		userProfile="(import self.nixosProfiles.users.common (args // { username = \"$username\"; }))"
	fi
	roles=()
	basename --suffix=.nix $NIXOS_DIR/roles/*.nix | while read -r line; do
		roles+=("$line")
	done
	if [ -z "$role" ]; then
		echo Select configuration role:
		select role in "${roles[@]}"; do
			break
		done
	fi
	script=$(
		cat <<-EOS
		mkdir -p $configurationDir
		nix eval --raw --impure --expr builtins.currentSystem > $configurationDir/system
		nixos-generate-config --show-hardware-config > $configurationDir/hardware-configuration.nix
		cat <<-EOF >$configurationDir/default.nix
		{ inputs, ... }@args:

		{
		  imports = with inputs; [
		    ./hardware-configuration.nix
		    self.nixosRoles.$role
		    $userProfile
		  ];
		}
		EOF
		git -C $configurationDir add .
		EOS
	)
	peval "$script"
}

if is_mounted $ROOT_MOUNT && ask "Perform installation?" n "$install"; then
	if ! [ -f $NIXOS_DIR/flake.nix ] && ask "No valid configuration found. Generate new configuration?" n; then
		peval rm -rf $NIXOS_DIR
		peval mkdir -p $NIXOS_DIR
		peval git clone https://github.com/ners/NixOS $NIXOS_DIR
		peval chown 1000:1000 -R $NIXOS_DIR
	fi
	if ! [ -f $NIXOS_DIR/flake.nix ]; then
		fatal "Cannot install: no configuration found!"
	fi
	configurations=( 'Create New' )
	nix flake show path:$NIXOS_DIR --json | jq --raw-output '.nixosConfigurations|keys[]' | while read -r line; do
		configurations+=("$line")
	done
	if [ -z "$configuration" ]; then
		echo Select existing configuration, or create a new one:
		select c in "${configurations[@]}"; do
			configuration=""
			case $c in
				'Create New' ) create_new_configuration ;;
				* ) configuration=$c ;;
			esac
			break
		done
	fi
	peval nixos-install --flake "$NIXOS_DIR#$configuration" --impure --no-root-password
fi
