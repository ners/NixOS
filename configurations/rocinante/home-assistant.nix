{ config, inputs, pkgs, ... }:

let
  name = "Nest";
  port = 8123;
in
with builtins;
{
  disabledModules = [ "services/misc/home-assistant.nix" ];
  imports = [ (inputs.nixpkgs-master + "/nixos/modules/services/home-automation/home-assistant.nix") ];
  services.home-assistant = {
    enable = true;
    package = pkgs.master.home-assistant;
    config = with builtins; {
      homeassistant = {
        inherit name;
        latitude = 47.3769;
        longitude = 8.5417;
        unit_system = "metric";
        time_zone = config.time.timeZone;
        currency = "CHF";
        internal_url = "http://rocinante.nest:${toString port}";
      };
      http = {
        server_host = [ "0.0.0.0" "::"];
        server_port = port;
      };
    };
    lovelaceConfig = {
      title = name;
      views = [ {
        title = "Example";
        cards = [ {
          type = "markdown";
          title = "Lovelace";
          content = "Welcome to your **Lovelace UI**.";
        } ];
      } ];
    }; 
  };
}