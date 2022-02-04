{ pkgs, ... }:

{
  fileSystems."/".options = [
    "compress=zstd"
    "noatime"
    "nodiratime"
    "discard"
  ];

  fileSystems."/home".options = [
    "compress=zstd"
  ];

  swapDevices = [{
    device = "/swap/swapfile";
    size = 4096;
  }];

  boot.initrd.supportedFilesystems = [ "btrfs" ];
  environment.systemPackages = with pkgs; [ btrfs-progs compsize ];
}

