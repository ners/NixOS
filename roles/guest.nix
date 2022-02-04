{ pkgs, ... }:

# This module enables virtualisation guest agents and tools.
# These improve host-guest interaction when the configuration is used as a guest.
{
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.vmware.guest.enable = true;
  virtualisation.hypervGuest.enable = true;
  services.xe-guest-utilities.enable = true;

  # Broken because the dependency prl-tools does not exist for latest kernels:
  #   https://search.nixos.org/packages?type=packages&query=prl-tools
  # hardware.parallels.enable = true;
}
