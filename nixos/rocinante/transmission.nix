{ ... }:

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
      rpc-password = "{2cd1009e62a1466d5ad0bae354e178ebeace43dfuT0iEYsu";
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
