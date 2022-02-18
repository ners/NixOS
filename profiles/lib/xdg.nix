{ lib, ... }:

with builtins;
with lib;
{
  # Given a package, find all the desktop files it contains
  desktopFiles = with lib; pipef [
    (pkg: filesystem.listFilesRecursive "${storePath pkg}/share/applications")
    (filter (hasSuffix ".desktop"))
  ];

  # Given a desktop file, generate a list of mimetype it supports
  mimeTypes = with lib; pipef [
    readFile
    lines
    (filter (hasPrefix "MimeType="))
    (map (removePrefix "MimeType="))
    (map (splitString ";"))
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
  applications = with lib; pipef [ desktopFiles (map application) ];

  # Reverse the given application -> mimetypes pair to an attrset of the form mimetype -> application
  mimeApp = with lib; pipef [
    (app: map (mimeType: { name = mimeType; value = app.desktop; }) app.mimeTypes)
    listToAttrs
  ];

  # Given a package, generate mimetype -> application pairs for each application in it
  mimePkg = with lib; pipef [
    applications
    (map mimeApp)
    zipAttrs
  ];

  # Given a list of packages, generate mimeApps for each, then combine them into a single attrset
  mimePkgs = with lib; pipef [
    (map mimePkg)
    (zipAttrsWith (_: concatLists))
  ];
}
