{ inputs, ... }:

{
  imports = with inputs; [
    ./boot.nix
    ./dragoncat.nix
    ./gold.nix
    ./hardware-configuration.nix
    ./plex.nix
    ./transmission.nix
    ./windows.nix
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-pc
    nixos-hardware.nixosModules.common-pc-ssd
    self.nixosRoles.base
  ];

  services.nfs.server.enable = true;
}
