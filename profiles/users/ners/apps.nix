{ pkgs, lib, ... }:


# This file is responsible for defining default applications by mimetype.
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = lib.mimePkgs (with pkgs.unstable; [
      chromium
      darktable
      discord
      drawio
      element-desktop
      firefox-devedition-bin
      foliate
      plexamp
      signal-desktop
      slack
      sweethome3d.application
      tdesktop
      zoom-us
    ]);
  };
}
