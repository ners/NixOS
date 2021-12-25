{ config, pkgs, ... }:

{
  users.groups.gold = { };
  fileSystems."/mnt/Gold" = {
    device = "/dev/disk/by-partuuid/21943a02-0be3-4c15-b689-2e6a8b90dcfd";
    fsType = "btrfs";
    options = [ "compress=zstd" ];
  };

  services.samba.shares."Gold" = {
    path = "/mnt/Gold";
    browseable = "yes";
    "read only" = "no";
    "guest ok" = "no";
    "create mask" = "0644";
    "directory mask" = "0755";
    "force user" = "dragoncat";
    "force group" = "gold";
  };
}
