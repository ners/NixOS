# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c393bb6d-f50f-4622-a994-385cfc829ca7";
    fsType = "btrfs";
    options = [ "subvol=root" ];
  };

  boot.initrd.luks.devices."cryptroot".device =
    "/dev/disk/by-uuid/1b98c7b1-cf90-4daa-8941-f9735903aba5";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F0A4-ECA9";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/c393bb6d-f50f-4622-a994-385cfc829ca7";
    fsType = "btrfs";
    options = [ "subvol=home" ];
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/c393bb6d-f50f-4622-a994-385cfc829ca7";
    fsType = "btrfs";
    options = [ "subvol=swap" ];
  };

  swapDevices = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}