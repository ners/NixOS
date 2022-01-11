{ config, pkgs, ... }:

{
  imports = [
    ../../profiles/base/boot.nix
    ../../profiles/graphical
    ../../profiles/graphical/ners.nix
    ./hardware-configuration.nix
    <nixos-hardware/lenovo/thinkpad/x1/9th-gen>
  ];

  networking.hostName = "godot";
}
