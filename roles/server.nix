{ inputs, lib, ... }:

{
  imports = with inputs.self; [
    nixosProfiles.boot
    nixosProfiles.btrfs
    nixosRoles.base
  ];

  services.xserver.enable = false;

  # Needed for NetworkManager
  services.dbus.enable = true;
}
