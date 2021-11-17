{ config, pkgs, ... }:
let
  unstableTarball = fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  unstableOverride =
    import (unstableTarball) { config = config.nixpkgs.config; };
in {
  imports = [
    ./boot.nix
    ./btrfs.nix
    ./dvorak.nix
    ./graphical.nix
    ./hardware-configuration.nix
    ./virtualisation.nix
    <home-manager/nixos>
  ];

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    packageOverrides = pkgs: { unstable = unstableOverride; };
  };

  networking = {
    hostName = "godot";
    networkmanager.enable = true;
    useNetworkd = true;
  };

  # Select internationalisation properties.
  i18n = { defaultLocale = "en_GB.UTF-8"; };
  console = { font = "Lat2-Terminus16"; };

  services = {
    fwupd.enable = true;
    geoclue2.enable = true;
    localtime.enable = true;
    openssh.enable = true;
    printing.enable = true;
  };

  location.provider = "geoclue2";
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
      home-manager
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

  system.stateVersion = "21.05";
}
