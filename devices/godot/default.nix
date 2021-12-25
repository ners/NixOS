{ config, pkgs, ... }:

{
  imports = [
    ../../boot.nix
    ../../graphical.nix
    ../../ners.nix
    <nixos-hardware/lenovo/thinkpad/x1/9th-gen>
  ];

  networking.hostName = "godot";
}
