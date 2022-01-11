{ config, pkgs, ... }:

{
  imports = [
    ../../profiles/base
    ../../profiles/graphical
    ../../profiles/graphical/ners.nix
    ./hardware-configuration.nix
    <nixos-hardware/common/pc>
    <nixos-hardware/common/pc/ssd>
    <nixos-hardware/common/cpu/intel>
    <nixos-hardware/common/gpu/amd>
  ];

  networking.hostName = "normandy";

  hardware.keyboard.zsa.enable = true;
}
