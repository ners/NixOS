{ config, pkgs, ... }:

let modifier = config.wayland.windowManager.sway.config.modifier;
in
{
  home.packages = with pkgs; [
    grim
    sway-contrib.grimshot
  ];

  wayland.windowManager.sway.config.keybindings = {
    "Control+Print" = "exec grimshot save area";
    "Control+Shift+Print" = "exec grimshot copy area";
    "Alt+Print" = "exec grimshot save window";
    "Alt+Shift+Print" = "exec grimshot copy window";
  };
}
