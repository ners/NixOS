{ config, inputs, pkgs, lib, ... }:

let
  name = "Nest";
  port = 8123;
  skipTests = p: p.overrideAttrs (_: {
    pytestCheckPhase = ''
      echo skipped pytestCheckPhase
    '';
  });
in
with builtins;
{
  disabledModules = [ "services/home-automation/home-assistant.nix" ];
  imports = [ (inputs.nixpkgs-unstable + "/nixos/modules/services/home-automation/home-assistant.nix") ];
  services.home-assistant = {
    enable = true;
    package = skipTests (pkgs.unstable.home-assistant.override {
      extraPackages = ps: with ps; [
        accuweather
        (skipTests aiogithubapi)
        aioharmony
        aiohomekit
        aiohue
        denonavr
        fnvhash
        ha-ffmpeg
        hap-python
        librouteros
        plexapi
        pyatv
        pyheos
        pykodi
        pylitterbot
        pyprusalink
        pyqrcode
        speedtest-cli
        spotipy
        transmissionrpc
      ];
    });
    config = {
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
        server_host = [ "0.0.0.0" "::" ];
        server_port = port;
      };
      frontend = { };
      python_script = { };
      logger.default = "info";
      automation = "!include automations.yaml";
      sensor = [
        {
          platform = "systemmonitor";
          resources = [
            {
              type = "load_1m";
            }
            {
              type = "processor_use";
            }
            {
              type = "processor_temperature";
            }
            {
              type = "memory_use_percent";
            }
            {
              type = "disk_use_percent";
              arg = "/";
            }
            {
              type = "disk_use_percent";
              arg = "/mnt/Gold";
            }
          ];
        }
      ];
    };
    configWritable = true;
    lovelaceConfigWritable = true;
  };
}

