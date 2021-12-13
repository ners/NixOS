{ config, pkgs, ... }:
let unstable = import <nixos-unstable> { config.allowUnfree = true; };
in {
  imports = [
    ./boot.nix
    ./btrfs.nix
    ./dvorak.nix
    ./graphical.nix
    ./hardware-configuration.nix
    ./virtualisation.nix
    ./devices/normandy
    <home-manager/nixos>
  ];

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    packageOverrides = pkgs: { unstable = unstable; };
  };

  networking = {
    networkmanager.enable = true;
    useNetworkd = true;
  };

  # Select internationalisation properties.
  i18n = { defaultLocale = "en_GB.UTF-8"; };
  console = { font = "Lat2-Terminus16"; };

  services.openssh.enable = true;

  time.timeZone = "Europe/Zurich";

  users = {
    defaultUserShell = pkgs.zsh;
    users.root = { initialHashedPassword = ""; };
    users.ners = {
      isNormalUser = true;
      isSystemUser = false;
      createHome = true;
      initialHashedPassword =
        "$6$P8pZJbrdjFXP7Bkf$CSxDmrTTO6o5pWUVXW0hy/c.Zdf7WtzNOPk1KiEDrDtyDf8x6V.ZvSzhh8kJWx0DKpObq4077SH1BRZZ0wgU/0";
      extraGroups =
        [ "audio" "libvirtd" "networkmanager" "video" "wheel" "dialout" ];
    };
  };
  home-manager.users.ners = import ./home/ners/home.nix;

  environment = {
    enableDebugInfo = true;
    systemPackages = with pkgs; [
      exfat
      expect
      file
      gitAndTools.gitFull
      gnumake
      htop
      jq
      killall
      moreutils
      neovim
      nix-index
      pciutils
      pv
      ripgrep
      sshfs-fuse
      tio
      tmux
      tree
      usbutils
      wget
    ];
    shells = with pkgs; [ bashInteractive zsh ];
    variables = { EDITOR = "nvim"; };
  };

  networking.firewall.enable = false;

  security.tpm2 = {
    enable = true;
    abrmd.enable = true;
  };

  system.stateVersion = "21.11";
}
