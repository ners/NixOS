{ config, lib, pkgs, ... }:

with lib;

{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader = {
    timeout = mkDefault 3;
    grub.enable = false;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.initrd.availableKernelModules = [ "aesni_intel" "cryptd" ];

  boot.initrd.luks.devices.cryptroot = {
    device = mkDefault "/dev/disk/by-partlabel/LUKS";
    preLVM = mkForce true;
    allowDiscards = mkForce true;
  };
}
