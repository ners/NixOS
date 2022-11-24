{ inputs, lib, ... }:

{
  imports = with inputs.self; [
    roles.base
  ];

  services.xserver.enable = lib.mkForce false;

  # Needed for NetworkManager
  services.dbus.enable = true;
}
