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
        gfxmodeEfi = "1920x1080";
        # theme = pkgs.nixos-grub2-theme;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
