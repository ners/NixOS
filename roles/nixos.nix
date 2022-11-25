{ inputs, pkgs, lib, ... }:

{
  imports = with inputs; [
    self.roles.base
    self.profiles.boot
    self.profiles.btrfs
    self.profiles.dvorak
    self.profiles.network
    self.profiles.ssh
    self.profiles.zram
  ];

  i18n.defaultLocale = "en_GB.UTF-8";

  time.timeZone = "Europe/Zurich";

  users.users.root.initialHashedPassword = "";

  environment = {
    systemPackages = with pkgs; [
      bridge-utils
      dconf
      fwupd
      fwupd-efi
      iproute
      lshw
      ncdu
      nixos-option
      nixos-update
      parted
      pciutils
      tunctl
      unzip
      usbutils
    ];
    variables = { EDITOR = "nvim"; };
  };
}
