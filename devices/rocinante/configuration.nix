{ config, pkgs, ... }:

{
  imports = [
    ../../profiles/base
    ./boot.nix
    ./dragoncat.nix
    ./gold.nix
    ./hardware-configuration.nix
    ./nfs.nix
    ./plex.nix
    ./transmission.nix
    ./windows.nix
    <nixos-hardware/common/cpu/amd>
    <nixos-hardware/common/pc/ssd>
    <nixos-hardware/common/pc>
  ];

  networking.hostName = "rocinante";
}
