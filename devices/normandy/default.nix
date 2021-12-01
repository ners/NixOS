{ config, pkgs, ... }:

{
  imports = [
    <nixos-hardware/common/pc>
    <nixos-hardware/common/pc/ssd>
    <nixos-hardware/common/cpu/intel>
    <nixos-hardware/common/gpu/amd>
  ];

  networking.hostName = "normandy";
}
