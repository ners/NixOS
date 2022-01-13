{ config, pkgs, lib, ... }:

{
  users.groups.gold.gid = 999;
  fileSystems."/mnt/Gold" = {
    device = lib.mkDefault "/dev/disk/by-label/Gold";
    fsType = "btrfs";
    options = [ "compress=zstd" ];
  };

  services.nfs.server.exports = ''
    /mnt/Gold *(rw,sync,no_root_squash,all_squash,anonuid=${builtins.toString config.users.users.dragoncat.uid},anongid=${builtins.toString config.users.groups.gold.gid})
  '';
}
