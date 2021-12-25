{ config, pkgs, ... }:

{
  services.transmission = {
    enable = true;
    settings = {
      performanceNetParameters = true;
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist-enabled = false;
      rpc-host-whitelist-enabled = false;
      rpc-authentication-required = true;
      rpc-username = "dragoncat";
      rpc-password = "{4731702a15712d42caf5a3233b20a6e4e25cf972yceOFpRr";
      peer-limit-per-torrent = 100;
      peer-limit-global = 100000;
      download-queue-size = 50;
      message-level = 2;
      dht-enabled = false;
      pex-enabled = false;
      lpd-enabled = false;
      incomplete-dir-enabled = false;
      cache-size-mb = 12;
    };
  };

  systemd.services.transmission.serviceConfig.BindPaths =
    [ "/mnt/Gold/Trackers" ];

  users.groups.transmission = { };
  users.users.transmission.extraGroups = [ "transmission" "gold" ];
}
