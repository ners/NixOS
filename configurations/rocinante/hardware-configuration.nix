# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "vfio_pci" "xhci_pci" "ahci" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/05016c6b-71b1-4b3f-b711-35eb02cca0a9";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/05016c6b-71b1-4b3f-b711-35eb02cca0a9";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/swap" =
    {
      device = "/dev/disk/by-uuid/05016c6b-71b1-4b3f-b711-35eb02cca0a9";
      fsType = "btrfs";
      options = [ "subvol=swap" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/B10C-F520";
      fsType = "vfat";
    };

  fileSystems."/mnt/Gold" =
    {
      device = "/dev/sda1";
      fsType = "btrfs";
    };

  swapDevices = [ ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
