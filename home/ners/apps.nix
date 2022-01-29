{ config, pkgs, ... }:

with builtins;

let
  pipe = list: initial: pkgs.lib.pipe initial list;
  lines = pkgs.lib.splitString "\n";

  # Given a package, find all the desktop files it contains
  desktopFiles = pipe [
    (pkg: pkgs.lib.filesystem.listFilesRecursive "${pkg}/share/applications")
    (filter (pkgs.lib.hasSuffix ".desktop"))
  ];

  # Given a desktop file, generate a list of mimetype it supports
  mimeTypes = pipe [
    readFile
    lines
    (filter (pkgs.lib.hasPrefix "MimeType="))
    (map (pkgs.lib.removePrefix "MimeType="))
    (map (pkgs.lib.splitString ";"))
    concatLists
    (filter (str: stringLength str > 0))
    (map unsafeDiscardStringContext)
  ];

  # Given a desktop file, pair it with a list of mimetypes it supports
  application = file: {
    desktop = baseNameOf file;
    mimeTypes = mimeTypes file;
  };

  # Given a package, find all its application desktop files and generate applications from them
  applications = pipe [ desktopFiles (map application) ];

  # Reverse the given application -> mimetypes pair to an attrset of the form mimetype -> application
  mimeApp = pipe [
    (app: map (mimeType: { name = mimeType; value = app.desktop; }) app.mimeTypes)
    listToAttrs
  ];

  # Given a package, generate mimetype -> application pairs for each application in it
  mimePkg = pipe [
    applications
    (map mimeApp)
    pkgs.lib.zipAttrs
  ];

  # Given a list of packages, generate mimeApps for each, then combine them into a single attrset
  mimePkgs = pipe [ (map mimePkg) (pkgs.lib.zipAttrsWith (_: concatLists)) ];
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = mimePkgs (with pkgs; [
      drawio
      evince
      evolution
      firefox-devedition-bin
      foliate
      gnome-connections
      gnome.eog
      gnome.file-roller
      gnome.gnome-font-viewer
      gnome.nautilus
      mpv
      unstable.neovim-qt
      unstable.tdesktop
    ]);
  };
}
