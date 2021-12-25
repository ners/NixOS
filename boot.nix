{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader = {
    timeout = 3;
    grub.enable = false;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.initrd.availableKernelModules = [ "aesni_intel" "cryptd" ];

  boot.initrd.luks.devices.cryptroot = {
    # device = "/dev/disk/by-partlabel/LUKS";
    preLVM = true;
    allowDiscards = true;
  };
}
