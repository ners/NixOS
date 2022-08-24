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

  services.beesd.filesystems = {
    root = {
      spec = "LABEL=NixOS";
      hashTableSizeMB = 256;
      verbosity = "crit";
      extraOptions = [ "--loadavg-target" "2.0" ];
    };
  };
}
