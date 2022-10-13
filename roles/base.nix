{ inputs, pkgs, lib, ... }:

{
  imports = with inputs; [
    self.nixosProfiles.dvorak
    self.nixosProfiles.nix
  ];

  networking = {
    networkmanager.enable = true;
    useNetworkd = true;
    firewall.enable = false;
    dhcpcd.wait = "background";
    dhcpcd.extraConfig = "noarp";
  };

  systemd.services = {
    NetworkManager-wait-online.enable = false;
    systemd-udev-settle.enable = false;
  };

  i18n.defaultLocale = "en_GB.UTF-8";

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = lib.mkForce "no";
  };

  time.timeZone = "Europe/Zurich";

  users = {
    defaultUserShell = pkgs.zsh;
    users.root.initialHashedPassword = "";
  };

  environment = {
    enableDebugInfo = true;
    systemPackages = with pkgs; [
      aria2
      bat
      boxes
      bridge-utils
      dconf
      entr
      exfat
      expect
      file
      fwupd
      fwupd-efi
      fx
      git-lfs
      gitAndTools.gitFull
      gnumake
      htop
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
      subversion
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
    shells = with pkgs; [ bashInteractive zsh ];
    variables = { EDITOR = "nvim"; };
  };

  programs.zsh.enable = true;
}
