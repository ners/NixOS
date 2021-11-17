NixOS
=====

# Installation

## Partitioning
```sh
sudo su

sgdisk --zap-all -o \
    -n 1:0:+1G -t 1:EF00 -c 1:EFI \
    -n 2:0:0 -t 1:8200 -c 2:LUKS \
    /dev/nvme0n1

partprobe

cryptsetup luksFormat /dev/disk/by-partlabel/LUKS
cryptsetup luksOpen /dev/disk/by-partlabel/LUKS cryptroot

mkfs.fat -F32 -n EFI /dev/disk/by-partlabel/EFI
mkfs.btrfs -f -L NixOS /dev/disk/by-label/NixOS

mount /dev/disk/by-label/NixOS /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/swap
umount /mnt

mount -o subvol=root,compress=zstd /dev/disk/by-label/NixOS /mnt
mkdir -p /mnt/boot/efi /mnt/home /mnt/swap
mount /dev/disk/by-label/EFI /mnt/boot/efi
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

## Build config (install)
```
nix-build '<nixpkgs/nixos>' -A config.system.build.toplevel -I nixos-config=/mnt/etc/nixos/configuration.nix
nixos-install --no-root-passwd
```
