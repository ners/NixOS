NixOS
=====

# Creating the boot media

## Creating the ISO
```
nix-shell -p nixos-generators --run 'nixos-generate --format iso --configuration iso-image/default.nix'
```

## Burn the ISO to USB drive
```
sudo dd if=result/iso/nixos-*.iso of=/dev/disk/by-id/<drive> bs=8M status=progress
```

# Installation

## Partitioning
```sh
sudo su

sgdisk --zap-all -o \
    -n 1:0:+1G -t 1:EF00 -c 1:EFI \
    -n 2:0:0 -t 2:8300 -c 2:LUKS \
    /dev/nvme0n1

partprobe

cryptsetup luksFormat /dev/disk/by-partlabel/LUKS
cryptsetup luksOpen /dev/disk/by-partlabel/LUKS cryptroot

mkfs.fat -F32 -n EFI /dev/disk/by-partlabel/EFI
mkfs.btrfs -f -L NixOS /dev/mapper/cryptroot

partprobe

mount /dev/disk/by-label/NixOS /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/swap
umount /mnt

mount -o subvol=root,compress=zstd /dev/disk/by-label/NixOS /mnt
mkdir -p /mnt/boot /mnt/home /mnt/swap
mount /dev/disk/by-label/EFI /mnt/boot
mount -o subvol=home,compress=zstd /dev/disk/by-label/NixOS /mnt/home
mount -o subvol=swap /dev/disk/by-label/NixOS /mnt/swap

touch /mnt/swap/swapfile
chmod 600 /mnt/swap/swapfile
chattr +C /mnt/swap/swapfile
fallocate /mnt/swap/swapfile -l4g
mkswap /mnt/swap/swapfile
swapon /mnt/swap/swapfile
```

## Generate initial config
```
nixos-generate-config --root /mnt
```

## Add channels
```
nix-channel --add https://nixos.org/channels/nixos-21.11 nixos
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz home-manager
nix-channel --update
```

## Build config (install)
```
nix-build '<nixpkgs/nixos>' -A config.system.build.toplevel -I nixos-config=/mnt/etc/nixos/configuration.nix
nixos-install --no-root-passwd
```
