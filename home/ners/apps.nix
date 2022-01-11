{ config, pkgs, ... }:

with builtins;

let
  pipe = list: initial: pkgs.lib.pipe initial list;
  lines = pkgs.lib.splitString "\n";
  desktopFiles = pipe [
    (pkg: pkgs.lib.filesystem.listFilesRecursive "${pkg}/share/applications")
    (filter (pkgs.lib.hasSuffix ".desktop"))
  ];
  mimeTypes = pipe [
    readFile
    lines
    (filter (pkgs.lib.hasPrefix "MimeType="))
    (map (pkgs.lib.removePrefix "MimeType="))
    (map (pkgs.lib.splitString ";"))
    concatLists
    (filter (str: stringLength str > 0))
  ];
  application = file: {
    desktop = baseNameOf file;
    mimeTypes = mimeTypes file;
  };
  applications = pipe [ desktopFiles (map application) ];
  mimeApp = pipe [
    applications
    (map (app:
      map
        (mimeType: {
          name = mimeType;
          value = app.desktop;
        })
        app.mimeTypes))
    concatLists
    listToAttrs
  ];
  mimeApps = pipe [ (map mimeApp) pkgs.lib.zipAttrs ];
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = mimeApps (with pkgs; [
      evince
      evolution
      foliate
      gnome-connections
      gnome.eog
      gnome.file-roller
      gnome.gnome-font-viewer
      gnome.nautilus
      mpv
      neovim
      unstable.firefox-devedition-bin
    ]);
  };
}
