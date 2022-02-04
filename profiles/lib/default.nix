{ inputs
, lib ? inputs.nixpkgs-stable.lib
, hm-lib ? inputs.home-manager.lib
, ...
}:

lib.makeExtensible (self:
  with builtins;
  with lib;
  lib // hm-lib // pipe ./. [
    filesystem.listFilesRecursive
    (filter (file: hasSuffix ".nix" file && file != ./default.nix))
    (map (file: import file { lib = self; }))
    (foldr recursiveUpdate {})
  ]
)
