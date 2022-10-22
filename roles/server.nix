{ inputs, lib, ... }:

{
  imports = with inputs.self; [
    nixosRoles.base
  ];

  services.xserver.enable = lib.mkForce false;

  # Needed for NetworkManager
  services.dbus.enable = true;
}
