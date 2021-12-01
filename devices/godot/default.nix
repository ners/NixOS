{ config, pkgs, ... }:

{
  imports = [
    <nixos-hardware/lenovo/thinkpad/x1/9th-gen>
  ];

  networking.hostName = "godot";
}
