{ config, pkgs, ... }:

{
  users.groups.gold = { };
  fileSystems."/mnt/Gold" = {
    device = "/dev/disk/by-partuuid/21943a02-0be3-4c15-b689-2e6a8b90dcfd";
    fsType = "btrfs";
    options = [ "compress=zstd" ];
  };

  services.nfs.server.exports = ''
    /mnt/Gold *(rw,sync,no_root_squash,all_squash,anonuid=1000,anongid=1000)
  '';
}
