{ inputs, lib, ... }:

{
  imports = with inputs; [
    self.nixosRoles.base
  ];

  services.xserver.enable = false;

  # Needed for NetworkManager
  services.dbus.enable = true;
}
