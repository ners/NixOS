{ ... }:

{
  networking = {
    networkmanager.enable = true;
    useNetworkd = true;
    firewall.enable = false;
    dhcpcd.wait = "background";
    dhcpcd.extraConfig = "noarp";
  };

  systemd.services = {
    NetworkManager-wait-online.enable = false;
    systemd-udev-settle.enable = false;
  };
}
