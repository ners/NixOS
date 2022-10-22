{ inputs, ... }:

{
  imports = with inputs; [
    ./boot.nix
    ./gold.nix
    ./hardware-configuration.nix
    ./home-assistant
    ./netdata.nix
    ./plex.nix
    ./transmission.nix
    ./windows
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-pc
    nixos-hardware.nixosModules.common-pc-ssd
    self.nixosProfiles.users.dragoncat
    self.nixosRoles.server
  ];

  services.nfs.server.enable = true;
}
