NixOS
=====

# Installation

```sh
(
echo o       # create a new empty GUID partition table (GPT)
echo y       # This option deletes all partitions and creates a new protective MBR. Proceed? (Y/N)
echo n       # Add a new partition
echo 1       # Partition number
echo         # First sector (Accept default: 2048)
echo +1G     # Last sector
echo EF00    # Partition type hex code
echo n       # Add a new partition
echo 2       # Partition number
echo         # First sector (Accept default)
echo         # Last sector (Accept default: full disk)
echo         # Partition type hex code (accept default: 8300)
echo c       # change a partition's name
echo 1       # Partition number
echo EFI     # Partition name
echo c       # change a partition's name
echo 2       # Partition number
echo NixOS   # Partition name
echo w       # write table to disk and exit
) | sudo gdisk /dev/nvme0n1

mkfs.fat -F32 -n EFI /dev/disk/by-partlabel/EFI
mkfs.btrfs -f -L NixOS /dev/disk/by-partlabel/NixOS

mount -o compress=zstd /dev/disk/by-partlabel/NixOS /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
# btrfs subvolume create /mnt/swap
umount /mnt

mount -o subvol=root,compress=zstd /dev/disk/by-partlabel/NixOS /mnt
mkdir -p /mnt/boot/efi /mnt/home
mount /dev/disk/by-partlabel/EFI /mnt/boot/efi
mount -o subvol=home,compress=zstd /dev/disk/by-partlabel/NixOS /mnt/home
```
