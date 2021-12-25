{ config, pkgs, ... }:

{
  imports = [
    ../../boot.nix
    ../../graphical.nix
    ../../ners.nix
    <nixos-hardware/common/pc>
    <nixos-hardware/common/pc/ssd>
    <nixos-hardware/common/cpu/intel>
    <nixos-hardware/common/gpu/amd>
  ];

  networking.hostName = "normandy";
}
