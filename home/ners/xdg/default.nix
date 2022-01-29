{ config, pkgs, ... }:

with builtins;

{
  xdg.configFile = pkgs.lib.pipe ./. [
    pkgs.lib.filesystem.listFilesRecursive
    (filter (file: ! pkgs.lib.hasSuffix ".nix" file))
    (map (file: {
      name = pkgs.lib.removePrefix "${toString ./.}/" (toString file);
      value = { source = file; };
    }))
    listToAttrs
  ];
}
