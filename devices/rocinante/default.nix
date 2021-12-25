{ config, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./dragoncat.nix
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
}
