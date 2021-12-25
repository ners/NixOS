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
      "image/apng" = image-viewer;
      "image/avif " = image-viewer;
      "image/bmp" = image-viewer;
      "image/gif" = image-viewer;
      "image/jpeg" = image-viewer;
      "image/png" = image-viewer;
      "image/svg+xml" = image-viewer;
      "image/tiff" = image-viewer;
      "image/vnd.microsoft.icon" = image-viewer;
      "image/webp" = image-viewer;
      "inode/directory" = file-manager;
      "text/calendar" = email;
      "text/html" = browser;
      "text/plain" = editor;
      "video/mp2t" = video-viewer;
      "video/mp4" = video-viewer;
      "video/mpeg" = video-viewer;
      "video/webm" = video-viewer;
      "video/x-msvideo" = video-viewer;
      "x-scheme-handler/chrome" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/mailto" = email;
      "x-scheme-handler/tg" = [ "telegramdesktop.desktop" ];
    };
  };
}
