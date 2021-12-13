{ config, pkgs, ... }:

let
  archive-manager = [ "org.gnome.FileRoller.desktop" ];
  browser = [ "firefox.desktop" ];
  document-viewer = [ "org.gnome.Evince.desktop" ];
  editor = [ "nvim-qt.desktop" ];
  email = [ "org.gnome.Evolution.desktop" ];
  file-manager = [ "org.gnome.Nautilus.desktop" ];
  image-viewer = [ "org.gnome.eog.desktop" ];
  video-viewer = [ "mpv.desktop" ];
in {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = document-viewer;
      "application/x-extension-htm" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xht" = browser;
      "application/x-extension-xhtml" = browser;
      "application/xhtml+xml" = browser;
      "image/*" = image-viewer;
      "video/*" = video-viewer;
      "inode/directory" = file-manager;
      "text/calendar" = email;
      "text/html" = browser;
      "text/plain" = editor;
      "x-scheme-handler/chrome" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/mailto" = email;
      "x-scheme-handler/tg" = [ "telegramdesktop.desktop" ];
    };
  };
}
