{ inputs, pkgs, ... }:

{
  imports = with inputs; [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.common-cpu-intel
    nixos-hardware.nixosModules.common-gpu-amd
    nixos-hardware.nixosModules.common-pc
    nixos-hardware.nixosModules.common-pc-ssd
    self.nixosRoles.desktop
    self.nixosProfiles.users.ners
  ];

  systemd.network.wait-online.extraArgs = [
    "--interface=eno2"
  ];

  hardware.keyboard.zsa.enable = true;

  environment.systemPackages = with pkgs; [
    wally-cli
  ];
}
