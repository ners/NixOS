{ config, lib, pkgs, ... }:

let
  inherit (lib) mkDefault;
  hasEfi = config.fileSystems."/boot".fsType == "vfat";
in
{
  boot = {
    # Use the latest kernel!
    kernelPackages = pkgs.linuxPackages_latest;

    # This will install a pre-release of zfs. Required because the ZFS module may not yet
    # support the latest kernel version and may report as broken.
    zfs.enableUnstable = true;

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
