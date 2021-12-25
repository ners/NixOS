{ pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      timeout = 3;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        fsIdentifier = "label";
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
