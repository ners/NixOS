{ pkgs, ... }:

{
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk.enable = true;
  gtk.theme.name = "Adwaita-dark";
  gtk.iconTheme.name = "Adwaita";

  qt.enable = true;
  qt.platformTheme = "gtk";
}
