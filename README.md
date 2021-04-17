NixOS
=====

# Installation

```sh
sudo sgdisk --zap-all /dev/nvme0n1
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
echo y       # confirm edit
) | sudo gdisk /dev/nvme0n1

sudo partprobe

sudo mkfs.fat -F32 -n EFI /dev/disk/by-partlabel/EFI
sudo mkfs.btrfs -f -L NixOS /dev/disk/by-partlabel/NixOS

sudo mount -o compress=zstd /dev/disk/by-partlabel/NixOS /mnt
sudo btrfs subvolume create /mnt/root
sudo btrfs subvolume create /mnt/home
# sudo btrfs subvolume create /mnt/swap
sudo umount /mnt

sudo mount -o subvol=root,compress=zstd /dev/disk/by-partlabel/NixOS /mnt
sudo mkdir -p /mnt/boot/efi /mnt/home
sudo mount /dev/disk/by-partlabel/EFI /mnt/boot/efi
sudo mount -o subvol=home,compress=zstd /dev/disk/by-partlabel/NixOS /mnt/home
```
