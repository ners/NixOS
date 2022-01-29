{ modulesPath, pkgs, lib, ... }:

with lib;

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-base.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix"
    <home-manager/nixos>

    ../profiles/base
    ../profiles/graphical
  ];

  boot = {
    kernelPackages = mkForce (pkgs.linuxPackages_latest.extend (final: prev: {
      zfs = prev.zfs.overrideAttrs (_: { meta.broken = false; });
    }));
    initrd.luks.devices = mkForce { };
  };

  users.users.nixos = {
    initialHashedPassword = mkForce "$6$zX.Yogo86CRvoRh1$Totj9JN3E6yCW38QEOPk43bZ8.axtM64jKpe3jfNrMISQohkqoCjwDAcCLVoVoYMSyvSsgSrcyqSKLRuV9y310";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOpF57zQbYYnhtJfE83BNLj4nFwkv9Og3jqPJVvTlvL ners"
    ];
  };
  home-manager.users.nixos = {
    programs.home-manager.enable = false;
    home = {
      username = "nixos";
      homeDirectory = "/home/nixos";
      stateVersion = "21.11";
    };

    nixpkgs.config.packageOverrides = _: {
      unstable = pkgs.unstable;
    };

    imports = [
      ../home/ners/apps.nix
      ../home/ners/dconf.nix
      ../home/ners/neovim
      ../home/ners/shell
      ../home/ners/xdg
    ];

    home.packages = with pkgs; [
      (callPackage ./wizard { })
      aria2
      bat
      boxes
      entr
      httpie
      nodejs
      unzip
    ];

  };
}
