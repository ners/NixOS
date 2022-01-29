#!/usr/bin/env zsh
set -e

function ask()
{
	while : ; do
		echo -n "$1 [y/N] "
		read -r answer
		case $answer in
			"") return 1 ;;
			[yY]*) return 0 ;;
			[nN]*) return 1 ;;
		esac
	done
}

function peval()
{
	echo $(tput dim)$@$(tput sgr 0)
	eval $@
}

EFI_LABEL=EFI
LUKS_LABEL=LUKS
NIXOS_LABEL=NixOS
LUKS_DEVICE=/dev/disk/by-partlabel/$LUKS_LABEL
LUKS_NAME=cryptroot
LUKS_OPEN_DEVICE=/dev/mapper/$LUKS_NAME
NIXOS_DEVICE=/dev/disk/by-label/$NIXOS_LABEL
EFI_DEVICE=/dev/disk/by-partlabel/$EFI_LABEL

function isMounted()
{
	mount | awk "{if (\$3 == \"$1\") {exit 0}} ENDFILE{exit -1}"
}

function maybeUnmount()
{
	if isMounted $1; then
		peval umount "$@"
	fi
}

function luks_open()
{
	if [ -b $LUKS_DEVICE ] && ! [ -b $LUKS_OPEN_DEVICE ]; then
		peval cryptsetup luksOpen $LUKS_DEVICE $LUKS_NAME
	fi
}

function luks_open()
{
	if [ -b $LUKS_OPEN_DEVICE ]; then
		peval cryptsetup close $LUKS_NAME
	fi
}

function unmount_all()
{
	maybeUnmount /mnt/boot
	maybeUnmount /mnt/home
	maybeUnmount /mnt/swap
	maybeUnmount /mnt
	luks_close
}

function mount_all()
{
	luks_open
	isMounted /mnt || peval mount -o subvol=root,compress=zstd $NIXOS_DEVICE /mnt
	peval mkdir -p /mnt/boot /mnt/home /mnt/swap
	isMounted /mnt/boot || peval mount $EFI_DEVICE /mnt/boot
	isMounted /mnt/home || peval mount -o subvol=home,compress=zstd $NIXOS_DEVICE /mnt/home
	isMounted /mnt/swap || peval mount -o subvol=swap $NIXOS_DEVICE /mnt/swap
}

function create_partitions()
{
	unmount_all
	IFS=$'\r\n' disks=($(lsblk --raw --nodeps --noheadings | awk '{print $1,"("$4")"}'))
	if [ ${#disks[@]} -lt 1 ]; then
		echo "error: no disks found!" >&2
		exit 1
	elif [ ${#disks[@]} -eq 1 ]; then
		disk=${disks[1]}
	else
		select disk in $disks; do
			[ -n "$disk" ] && break || continue
		done
	fi
	disk=/dev/$(echo $disk | awk '{print $1}')
	if ! [ -b "$disk" ]; then
		echo "error: cannot find disk: $disk" >&2
		exit 1
	fi
	echo "Selected disk: $disk"
	if ask "Encrypt data partition?"; then
		peval sgdisk --zap-all -o \
			-n 1:0:+1G -t 1:EF00 -c 1:$EFI_LABEL \
			-n 2:0:0 -t 2:8300 -c 2:$LUKS_LABEL \
			$disk
		peval partprobe
		peval cryptsetup luksFormat $LUKS_DEVICE
		luks_open
		peval mkfs.btrfs -f -L $NIXOS_LABEL /dev/mapper/$LUKS_NAME
	else
		peval sgdisk --zap-all -o \
			-n 1:0:+1G -t 1:EF00 -c 1:$EFI_LABEL \
			-n 2:0:0 -t 2:8300 -c 2:$NIXOS_LABEL \
			$disk
		peval partprobe
		peval mkfs.btrfs -f -L $NIXOS_LABEL /dev/disk/by-partlabel/$NIXOS_LABEL
	fi
	peval mkfs.fat -F32 -n $EFI_LABEL $EFI_DEVICE
	peval partprobe
	peval mount $NIXOS_DEVICE /mnt
	peval btrfs subvolume create /mnt/root
	peval btrfs subvolume create /mnt/home
	peval btrfs subvolume create /mnt/swap
	peval umount /mnt
	mount_all
	peval touch /mnt/swap/swapfile
	peval chmod 600 /mnt/swap/swapfile
	peval chattr +C /mnt/swap/swapfile
	peval fallocate /mnt/swap/swapfile -l4g
	peval mkswap /mnt/swap/swapfile
	peval swapon /mnt/swap/swapfile
}

if ask "Create fresh partitions?"; then create_partitions
elif ask "Mount partitions?"; then mount_all
fi

if isMounted /mnt \
	&& ! [ -f /mnt/etc/nixos/hardware-configuration.nix ] \
	&& ask "Generate config?"; then
	peval nixos-generate-config --root /mnt
fi

if ask "Add channels?"; then
	peval nix-channel --add https://nixos.org/channels/nixos-21.11 nixos
	peval nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
	peval nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
	peval nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz home-manager
	peval nix-channel --update
fi
