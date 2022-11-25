{ inputs, lib, ... }:

{
  imports = with inputs.self; [
    roles.nixos
  ];

  services.xserver.enable = lib.mkForce false;

  # Needed for NetworkManager
  services.dbus.enable = true;
}
