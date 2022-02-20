{ config, lib, ... }:

with builtins;
with lib;

let
  mountPoint = "/mnt/Gold";
  uid = config.users.users.dragoncat.uid;
  gid = 999;
in
{
  users.groups.gold.gid = gid;
  fileSystems.${mountPoint} = {
    device = mkDefault "/dev/disk/by-label/Gold";
    fsType = "btrfs";
    options = [ "compress=zstd" ];
  };

  services.nfs.server.exports = ''
    ${mountPoint} *(rw,sync,no_root_squash,all_squash,insecure,anonuid=${toString uid},anongid=${toString gid})
  '';
}
