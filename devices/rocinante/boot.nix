{ pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = mkForce false;
    grub = {
      enable = mkForce true;
      efiSupport = true;
      device = "nodev";
      fsIdentifier = "label";
      gfxmodeEfi = "1920x1080";
      # theme = pkgs.nixos-grub2-theme;
    };
  };
}
