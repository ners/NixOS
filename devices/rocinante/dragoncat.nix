{ pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];
  users.users.dragoncat = {
    uid = 1000;
    isNormalUser = true;
    isSystemUser = false;
    createHome = true;
    initialHashedPassword =
      "$6$P8pZJbrdjFXP7Bkf$CSxDmrTTO6o5pWUVXW0hy/c.Zdf7WtzNOPk1KiEDrDtyDf8x6V.ZvSzhh8kJWx0DKpObq4077SH1BRZZ0wgU/0";
    extraGroups = [
      "dragoncat"
      "audio"
      "dialout"
      "libvirtd"
      "networkmanager"
      "qemu-libvirtd"
      "video"
      "wheel"
      "plex"
      "gold"
      "transmission"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMOpF57zQbYYnhtJfE83BNLj4nFwkv9Og3jqPJVvTlvL ners"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMxceZEJ4aQXkvHWWDh5TXNk9XdpIZFQKGhQGAZIeLxr rekk"
    ];
  };
  users.groups.dragoncat.gid = 1000;
  home-manager.users.dragoncat = {
    programs.home-manager.enable = false;
    home = {
      username = "dragoncat";
      homeDirectory = "/home/dragoncat";
      stateVersion = "21.11";
    };

    imports = [
      ../../home/ners/neovim.nix
      ../../home/ners/shell.nix
    ];

    home.packages = with pkgs; [
      aria2
      bat
      boxes
      entr
      httpie
      nix-index
      nodejs
      unzip
    ];
  };
}