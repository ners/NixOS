{ pkgs, lib, ... }:

{
  boot.loader = {
    systemd-boot.enable = lib.mkForce false;
    grub = {
      enable = lib.mkForce true;
      efiSupport = true;
      device = "nodev";
      fsIdentifier = "label";
      gfxmodeEfi = "1920x1080";
      # theme = pkgs.nixos-grub2-theme;
    };
  };
}
