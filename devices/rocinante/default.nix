{ config, pkgs, ... }:

{
  imports = [
    ./gold.nix
    ./plex.nix
    ./samba.nix
    ./transmission.nix
    ./windows.nix
    <nixos-hardware/common/cpu/amd>
    <nixos-hardware/common/pc/ssd>
    <nixos-hardware/common/pc>
  ];

  networking.hostName = "rocinante";

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

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      timeout = 3;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        fsIdentifier = "label";
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
