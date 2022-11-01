{ inputs, pkgs, lib, ... }:

{
  imports = with inputs; [
    self.nixosProfiles.boot
    self.nixosProfiles.btrfs
    self.nixosProfiles.dvorak
    self.nixosProfiles.network
    self.nixosProfiles.nix
    self.nixosProfiles.ssh
    self.nixosProfiles.zram
    self.nixosProfiles.zsh
  ];

  i18n.defaultLocale = "en_GB.UTF-8";

  time.timeZone = "Europe/Zurich";

  users.users.root.initialHashedPassword = "";

  environment = {
    enableDebugInfo = true;
    systemPackages = with pkgs; [
      aria2
      bat
      boxes
      bridge-utils
      btop
      dconf
      entr
      exa
      exfat
      expect
      fd
      file
      fwupd
      fwupd-efi
      fx
      iproute
      jq
      killall
      libfaketime
      lshw
      moreutils
      nano
      ncdu
      neofetch
      neovim
      nix-diff
      nix-index
      nix-top
      nixos-option
      nixos-update
      nvd
      parted
      pciutils
      perl534Packages.FileMimeInfo
      pv
      ripgrep
      smartmontools
      sshfs-fuse
      tio
      tmux
      tree
      tunctl
      unzip
      usbutils
      wget
      xh
      zip
    ];
    variables = { EDITOR = "nvim"; };
  };
}
