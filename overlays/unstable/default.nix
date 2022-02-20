{ lib
, inputs
, system
, overlays
, ...
}@args:

self: super:
let
  mkOverlay = o: import o args;
  importPkgs = pkgs: import pkgs {
    config.allowUnfree = true;
    localSystem = { inherit system; };
    overlays = with builtins; lib.pipe overlays [
      (filter (o: o != ./.))
      (map mkOverlay)
    ];
  };
  unstable = importPkgs inputs.nixpkgs-unstable;
  master = importPkgs inputs.nixpkgs-master;
in
with builtins; with lib; pipe ./. [
  findModules
  attrValues
  (map (o: import o { inherit unstable master; } self super))
  (foldr recursiveUpdate { inherit unstable master; })
]
