{ nixosConfig, pkgs, lib, ... }:


# This file is responsible for defining default applications by mimetype.
let
  enable = nixosConfig.services.xserver.enable;
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
          evolution
          firefox-wayland
          gnome-connections
          gnome.eog
          gnome.file-roller
          gnome.nautilus
          gparted
          mpv
          neovim-qt
          rhythmbox
          transmission-gtk
          virt-manager
          virt-viewer
        ]);
      } else { };
  };
}
