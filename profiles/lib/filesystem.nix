{ lib, ... }:

with builtins;
with lib;
{
  filesInDir = pipef [
    readDir
    attrNames
  ];

  concatFilesInDir = separator: dir: pipe dir [
    filesInDir
    (map (name: readFile "${dir}/${name}"))
    (concatStringsSep separator)
  ];
}
