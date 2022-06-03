{ lib, ... }:

with builtins;
with lib;
{
  filesInDir = pipef [
    readDir
    attrNames
  ];

  concatDirFilesSep = separator: dir: pipe dir [
    filesInDir
    (map (name: readFile "${dir}/${name}"))
    (concatStringsSep separator)
  ];

  concatDirFiles = concatDirFilesSep "\n";
}
