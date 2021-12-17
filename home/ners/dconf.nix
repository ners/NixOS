{ config, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/background" = { picture-uri = ".background"; };
    "org/gnome/desktop/screensaver" = { picture-uri = ".background"; };

    "org/gnome/desktop/interface" = {
      font-antialiasing = "rgba";
      font-hinting = "full";
      gtk-im-module = "gtk-im-context-simple";
      gtk-theme = "Adwaita-dark";
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      executable-text-activation = "display";
      search-filter-time-type = "last_modified";
      search-view = "list-view";
      show-image-thumbnails = "always";
      thumbnail-limit = 10;
    };

    "org/gnome/nautilus/list-view" = { use-tree-view = "true"; };

    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///session" ];
      uris = [ "qemu:///session" ];
    };

    "org/gnome/gnome-system-monitor" = {
      cpu-smooth-graph = "true";
      cpu-stacked-area-chart = "true";
    };

  };
}
