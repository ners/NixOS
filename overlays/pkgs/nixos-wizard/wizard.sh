ensure_root "$@"

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
	luks_open
	maybe_mount -o subvol=root,compress=zstd $NIXOS_DEVICE $ROOT_MOUNT
	maybe_mount $EFI_DEVICE $BOOT_VOL
	maybe_mount -o subvol=home,compress=zstd $NIXOS_DEVICE $HOME_VOL
	maybe_mount -o subvol=swap $NIXOS_DEVICE $SWAP_VOL
	if [ -f $SWAP_FILE ] && ! is_swapped; then
		peval swapon $SWAP_FILE
	fi
}

if ask "Create fresh partitions?" n; then
	unmount_all
	IFS=$'\r\n' disks=("$(lsblk --noheadings --list --paths | grep disk | awk '{print $1,$4,$6,$7}')")
	if [ ${#disks[@]} -lt 1 ]; then
		fatal "error: no disks found!"
	elif [ ${#disks[@]} -eq 1 ]; then
		disk=${disks[0]}
	else
		select disk in "${disks[@]}"; do
			if [ -n "$disk" ]; then break; fi
		done
	fi
	disk=$(echo "$disk" | awk '{print $1}')
	if ! [ -b "$disk" ]; then
		fatal "error: cannot find disk: $disk"
	fi
	echo "Selected disk: $disk"
	if ask "Encrypt data partition?" y; then
		peval sgdisk --zap-all -o \
			-n 1:0:+1G -t 1:EF00 -c 1:$EFI_LABEL \
			-n 2:0:0 -t 2:8300 -c 2:$LUKS_LABEL \
			"$disk"
		peval partprobe
		peval cryptsetup luksFormat $LUKS_DEVICE
		luks_open
		peval mkfs.btrfs -f -L $NIXOS_LABEL /dev/mapper/$LUKS_NAME
	else
		peval sgdisk --zap-all -o \
			-n 1:0:+1G -t 1:EF00 -c 1:$EFI_LABEL \
			-n 2:0:0 -t 2:8300 -c 2:$NIXOS_LABEL \
			"$disk"
		peval partprobe
		peval mkfs.btrfs -f -L $NIXOS_LABEL /dev/disk/by-partlabel/$NIXOS_LABEL
	fi
	peval mkfs.fat -F32 -n $EFI_LABEL $EFI_DEVICE
	peval partprobe
	peval mount $NIXOS_DEVICE $ROOT_MOUNT
	peval btrfs subvolume create $ROOT_VOL
	peval btrfs subvolume create $HOME_VOL
	peval btrfs subvolume create $SWAP_VOL
	peval umount $ROOT_MOUNT
	mount_all
	peval touch $SWAP_FILE
	peval chmod 600 $SWAP_FILE
	peval chattr +C $SWAP_FILE
	peval fallocate $SWAP_FILE -l4g
	peval mkswap $SWAP_FILE
	peval swapon $SWAP_FILE
fi

if ! is_mounted $ROOT_MOUNT && ask "Mount partitions?" y; then mount_all; fi

function create_new_configuration()
{
	while : ; do
		echo -n "Enter new configuration name: "
		read -r configuration
		if [[ "$configuration" =~ ^[A-Za-z][A-Za-z0-9-]*$ ]]; then
			break
		fi
		error Invalid configuration name
	done
	configurationDir=$NIXOS_DIR/configurations/$configuration
	if [ -d "$configurationDir" ]; then return; fi
	while : ; do
		echo -n "Enter admin user name (ners): "
		read -r username
		if [ -z "$username" ]; then
			username=ners
		fi
		if [[ "$username" =~ ^[A-Za-z][A-Za-z0-9]*$ ]]; then
			break
		fi
		error Invalid username
	done
	if [ "$username" = ners ]; then
		userProfile=self.nixosProfiles.users.ners
	else
		userProfile="(import self.nixosProfiles.users.common (args // { username = \"$username\"; }))"
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
		    self.nixosRoles.desktop
		    $userProfile
		  ];
		}
		EOF
		EOS
	)
	peval "$script"
}

if is_mounted $ROOT_MOUNT && ask "Perform installation?" n; then
	if ! [ -f $NIXOS_DIR/flake.nix ] && ask "No valid configuration found. Generate new configuration?" n; then
		peval rm -rf $NIXOS_DIR
		peval mkdir -p $NIXOS_DIR
		peval git clone https://github.com/ners/NixOS $NIXOS_DIR
		peval chown 1000:1000 -R $NIXOS_DIR
	fi
	if ! [ -f $NIXOS_DIR/flake.nix ]; then
		fatal "Cannot install: no configuration found!"
	fi
	IFS=$'\r\n' configurations=('Create New' "$(nix flake show path:$NIXOS_DIR --json | jq --raw-output '.nixosConfigurations|keys[]')")
	echo Select existing configuration, or create a new one:
	select c in "${configurations[@]}"; do
		configuration=""
		case $c in
			'Create New' ) create_new_configuration ;;
			* ) configuration=$c ;;
		esac
		break
	done
	peval nixos-install --flake "$NIXOS_DIR#$configuration" --impure --no-root-passwd
fi
