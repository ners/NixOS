{ config, pkgs, ... }:

{
  services.plex = {
    enable = true;
    package = pkgs.unstable.plex;
  };
  users.users.plex.extraGroups = [ "plex" "gold" ];
}
