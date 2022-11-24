{ lib, ... }:

with lib;

{
  boot = {
    loader = {
      systemd-boot.enable = mkForce false;
      grub = {
        enable = mkForce true;
        efiSupport = true;
        gfxmodeEfi = "1920x1080";
        # theme = pkgs.nixos-grub2-theme;
      };
    };
  };
  hardware.video.hidpi.enable = true;
}
