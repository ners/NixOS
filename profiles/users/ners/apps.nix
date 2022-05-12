{ pkgs, lib, ... }:


# This file is responsible for defining default applications by mimetype.
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = lib.mimePkgs (with pkgs; [
      element-desktop
      unstable.chromium
      unstable.darktable
      unstable.discord
      unstable.drawio
      unstable.firefox-devedition-wayland
      unstable.foliate
      unstable.plexamp
      unstable.slack
      unstable.sweethome3d.application
      unstable.tdesktop
      unstable.zoom-us
    ]);
  };
}
