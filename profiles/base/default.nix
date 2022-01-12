{ config, lib, pkgs, ... }:

let unstable = import <nixos-unstable> { config.allowUnfree = true; };
in
{
  imports = [
    ./boot.nix
    ./btrfs.nix
    ./dvorak.nix
    ./virtualisation.nix
  ];

  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };
    package = pkgs.unstable.nix_2_5;
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
      preallocate-contents = false
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    packageOverrides = pkgs: { unstable = unstable; };
    #contentAddressedByDefault = true;
  };

  networking = {
    networkmanager.enable = true;
    useNetworkd = true;
    firewall.enable = false;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  services.openssh = {
    enable = true;
    passwordAuthentication = true;
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
      (callPackage ./nixos-update { })
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
      nixos-option
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

  programs.zsh.enable = true;

  security.tpm2 = {
    enable = true;
    abrmd.enable = true;
  };

  system.stateVersion = "21.11";
}
