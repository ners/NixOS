{ config, lib, pkgs, ... }:

let
  inherit (lib) mkDefault mkForce;
  hasEfi = (config.fileSystems."/boot".fsType or "") == "vfat";
in
{
  boot = {
    # Use the latest kernel!
    kernelPackages = mkForce pkgs.linuxPackages_latest;

    # Remove undesired filesystems such as ZFS that causes kernel breakages.
    supportedFilesystems = mkForce [ "vfat" "btrfs" "ext4" ];

    loader = {
      # The number of seconds for user intervention before the default boot option is selected.
      timeout = mkDefault 3;
      efi.canTouchEfiVariables = hasEfi;
      grub = {
        enable = mkDefault (!hasEfi);
        efiSupport = mkDefault false;
        device = "nodev";
        fsIdentifier = "label";
      };
      systemd-boot = {
        enable = mkDefault hasEfi;
        # The resolution of the console. A higher resolution displays more entries.
        consoleMode = "max";
      };
    };

    initrd = {
      availableKernelModules = [ "aesni_intel" "cryptd" ];
      # Use systemd for PID 1.
      systemd.enable = true;
    };
  };
}
