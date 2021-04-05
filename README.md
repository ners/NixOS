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
echo +100M   # Last sector
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

mkfs.fat -F32 -n EFI /dev/disk/by-name/EFI
mkfs.btrfs -f -L NixOS /dev/disk/by-name/NixOS

mount -o compress=zstd /dev/disk/by-name/NixOS /mnt
mkdir -p /mnt/boot/efi
mount /dev/disk/by-name/EFI /mnt/boot/efi
```
