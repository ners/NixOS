{ config, pkgs, ... }:

{
  services.plex.enable = true;
  users.users.plex.extraGroups = [ "plex" "gold" ];
}
