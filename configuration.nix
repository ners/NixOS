{ config, pkgs, ... }:
let
  unstableTarball = fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  unstableOverride =
    import (unstableTarball) { config = config.nixpkgs.config; };
in {
  imports = [
    ./bootloader.nix
    ./btrfs.nix
    ./dvorak.nix
    ./graphical.nix
    ./hardware-configuration.nix
    ./virtualisation.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    maxJobs = 16;
    extraOptions = ''
      binary-caches-parallel-connections = 50
      keep-outputs = true
      keep-derivations = true
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    packageOverrides = pkgs: { unstable = unstableOverride; };
  };

  networking = {
    hostName = "nixos";
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
      createHome = true;
      initialHashedPassword =
        "$6$P8pZJbrdjFXP7Bkf$CSxDmrTTO6o5pWUVXW0hy/c.Zdf7WtzNOPk1KiEDrDtyDf8x6V.ZvSzhh8kJWx0DKpObq4077SH1BRZZ0wgU/0";
      extraGroups =
        [ "audio" "libvirtd" "networkmanager" "video" "wheel" "dialout" ];
    };
  };

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
      silver-searcher
      sshfs-fuse
      tio
      tmux
      tree
      usbutils
      wget
    ];
    variables = { EDITOR = "nvim"; };
  };

  networking.firewall.enable = false;

  system.stateVersion = "21.05";
}
