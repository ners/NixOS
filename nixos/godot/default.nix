{ inputs, pkgs, ... }:

{
  imports = with inputs; [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
    Roles.desktop
    Profiles.users.ners
  ];

  systemd.network.wait-online.extraArgs = [
    "--interface=wlp0s20f3"
  ];
}
