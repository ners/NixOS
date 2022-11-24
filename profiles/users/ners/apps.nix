{ pkgs, lib, ... }:


# This file is responsible for defining default applications by mimetype.
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = lib.mimePkgs (with pkgs; [
      unstable.chromium
      unstable.darktable
      unstable.discord
      unstable.drawio
      unstable.element-desktop
      unstable.firefox-devedition-bin
      unstable.foliate
      unstable.plexamp
      unstable.signal-desktop
      unstable.slack
      unstable.sweethome3d.application
      unstable.tdesktop
      unstable.zoom-us
    ]);
  };
}
