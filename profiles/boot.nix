{ config, lib, pkgs, options, ... }:

with lib;

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest.extend (self: super: {
      zfs = super.zfs.overrideAttrs (_: { meta.broken = false; });
    });

    loader = {
      timeout = mkDefault 3;
      efi.canTouchEfiVariables = true;
      grub.enable = false;
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
    };
    initrd = {
      availableKernelModules = [ "aesni_intel" "cryptd" ];
      luks.devices = mkDefault {
        cryptroot = {
          device = mkDefault "/dev/disk/by-partlabel/LUKS";
          preLVM = mkForce true;
          allowDiscards = mkForce true;
        };
      };
    };
  };

  console = {
    earlySetup = true;
    packages = options.console.packages.default ++ [ pkgs.terminus_font ];
  };
}
