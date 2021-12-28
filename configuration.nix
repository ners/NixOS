{ config, pkgs, ... }:

let unstable = import <nixos-unstable> { config.allowUnfree = true; };
in {
  imports = [
    ./btrfs.nix
    ./device.nix
    ./dvorak.nix
    ./hardware-configuration.nix
    ./virtualisation.nix
  ];

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      preallocate-contents = false
    '';
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
  i18n.defaultLocale = "en_GB.UTF-8";
  console.font = "Lat2-Terminus16";

  services.openssh = {
    enable = true;
    passwordAuthentication = true;
    permitRootLogin = "no";
  };

  time.timeZone = "Europe/Zurich";

  users = {
    defaultUserShell = pkgs.zsh;
    users.root.initialHashedPassword = "";
  };

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
      nano
      neovim
      nix-index
      parted
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
