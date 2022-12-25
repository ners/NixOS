{ lib, ... }:

with lib;

{
  boot = {
    loader = {
      systemd-boot.enable = mkForce false;
      grub = {
        enable = mkForce true;
        efiSupport = true;
      };
    };
  };
  hardware.video.hidpi.enable = true;
}
