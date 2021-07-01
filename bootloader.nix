{ config, pkgs, ... }: {
  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-label/EFI";
    fsType = "vfat";
  };

  boot.loader = {
    systemd-boot.enable = true;
    timeout = 3;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      device = "nodev";
      efiSupport = true;
      enable = true;
      fsIdentifier = "label";
      gfxmodeEfi = "1920x1080";
      theme = pkgs.nixos-grub2-theme;
    };
  };
}
