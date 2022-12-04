{ nixosConfig
, pkgs
, lib
, ...
}:

let
  enable = nixosConfig.services.dbus.enable or false;
  debugEnable = with builtins;
    trace
      "dconf: ${if enable then "enable" else "disable"}"
      enable;
in
{
  dconf = {
    inherit enable;
    settings =
      if debugEnable then
        lib.dconfFlatten
          {
            org.gnome = {
              desktop = {
                interface = {
                  font-antialiasing = "grayscale";
                  font-hinting = "full";
                  gtk-im-module = "gtk-im-context-simple";
                  gtk-theme = "Adwaita-dark";
                  color-scheme = "prefer-dark";
                };
                peripherals = {
                  touchpad = {
                    speed = 0.5;
                    tap-to-click = true;
                    two-finger-scrolling-enabled = true;
                  };
                  mouse.speed = 0.5;
                  keyboard = {
                    repeat = true;
                    delay = 200;
                    repeat-interval = 10;
                  };
                };
              };
              shell.favorite-apps = [
                "firefox.desktop"
                "org.gnome.Console.desktop"
                "org.gnome.Nautilus.desktop"
              ];
              nautilus = {
                preferences = {
                  default-folder-viewer = "list-view";
                  executable-text-activation = "display";
                  search-filter-time-type = "last_modified";
                  search-view = "list-view";
                  show-image-thumbnails = "always";
                  thumbnail-limit = 10;
                };
                list-view.use-tree-view = true;
              };
              gnome-system-monitor = {
                cpu-smooth-graph = true;
                cpu-stacked-area-chart = true;
              };
              settings-daemon.plugins.color.night-light.enabled = true;
            };

            org.virt-manager = {
              connections = rec {
                uris = [ "qemu:///system" "qemu:///session" ];
                autoconnect = uris;
              };
              virt-manager.xmleditor-enabled = true;
              console.resize-guest = 1;
            };
          } else { };
  };
}
