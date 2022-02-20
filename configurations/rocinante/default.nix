{ inputs, ... }:

{
  imports = with inputs; [
    ./boot.nix
    ./dragoncat.nix
    ./gold.nix
    ./hardware-configuration.nix
    ./home-assistant.nix
    ./plex.nix
    ./transmission.nix
    ./windows.nix
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-pc
    nixos-hardware.nixosModules.common-pc-ssd
    self.nixosRoles.server
  ];

  services.nfs.server.enable = true;
}
