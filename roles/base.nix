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
      bridge_utils
      dconf
      entr
      exfat
      expect
      libfaketime
      file
      git-lfs
      gitAndTools.gitFull
      gnumake
      htop
      httpie
      iproute
      jq
      killall
      moreutils
      nano
      neofetch
      neovim
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
    ];
    shells = with pkgs; [ bashInteractive zsh ];
    variables = { EDITOR = "nvim"; };
  };

  programs.zsh.enable = true;

  security.tpm2 = {
    enable = true;
    abrmd.enable = true;
  };
}
