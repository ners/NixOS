{ pkgs, lib, ... }:


# This file is responsible for defining default applications by mimetype.
{
  xdg.mimeApps = {
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
  };
}
