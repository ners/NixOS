{ inputs, pkgs, ... }:

{
  imports = with inputs; [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
    self.nixosRoles.desktop
    self.nixosProfiles.users.ners
  ];
}
