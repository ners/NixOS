{ lib
, inputs
, overlays
, ...
}@args:

self: super:
let
  mkOverlay = o: import o args;
  importPkgs = pkgs: import pkgs {
    inherit (super) system;
    config.allowUnfree = true;
    overlays = with builtins; lib.pipe overlays [
      (filter (o: o != ./.))
      (map mkOverlay)
    ];
  };
  unstable = importPkgs inputs.nixpkgs-unstable;
  master = importPkgs inputs.nixpkgs-master;
  local =
    if builtins.pathExists /etc/nixpkgs
    then importPkgs /etc/nixpkgs
    else { };
in
with builtins; with lib; pipe ./. [
  findModules
  attrValues
  (map (o: import o { inherit unstable master; } self super))
  (foldr recursiveUpdate { inherit unstable master local; })
]
