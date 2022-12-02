{ nixosConfig, pkgs, lib, ... }:


# This file is responsible for defining default applications by mimetype.
let
  enable = nixosConfig.services.xserver.enable or false;
  debugEnable = with builtins;
    trace
      "xdg: ${if enable then "enable" else "disable"}"
      enable;
in
{
  xdg = {
    inherit enable;
    mimeApps =
      if debugEnable
      then {
        enable = true;
        defaultApplications = lib.mimePkgs (with pkgs; [
          evince
          firefox-wayland
          gnome-connections
          gnome.eog
          gnome.file-roller
          gnome.nautilus
          gparted
          mpv
          rhythmbox
          thunderbird
          transmission-gtk
          neovide
          virt-manager
          virt-viewer
        ]);
      } else { };
  };
}
