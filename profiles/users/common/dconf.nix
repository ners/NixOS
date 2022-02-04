{ pkgs, ... }:

with pkgs.lib;
let
  merge = { name, value }: assert assertMsg (length name > 1) "Dconf configuration requires at least two-level names";
    nameValuePair (concatStringsSep "/" (init name)) { ${last name} = value; };
  flatten = flattenAttrsWith merge;
in
{
  dconf.settings = flatten {
    org.gnome = {
      desktop = {
        interface = {
          font-antialiasing = "rgba";
          font-hinting = "full";
          gtk-im-module = "gtk-im-context-simple";
          gtk-theme = "Adwaita-dark";
        };
        peripherals.touchpad = {
          tap-to-click = true;
          two-finger-scrolling-enabled = true;
        };
      };

      shell.favorite-apps = [
        "firefox.desktop"
        "org.gnome.Terminal.desktop"
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

    };

    org.virt-manager = {
      connections =
        let uris = [ "qemu:///system" "qemu:///session" ];
        in
        {
          inherit uris;
          autoconnect = uris;
        };
      virt-manager.xmleditor-enabled = true;
      console.resize-guest = 1;
    };

    "com/github/johnfactotum/Foliate/view" = {
      autohide-cursor = false;
      font = "Serif 16";
    };
  };
}
