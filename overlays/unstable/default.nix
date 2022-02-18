{ lib
, inputs
, system
, overlays
, ...
}@args:

self: super:
let
  mkOverlay = o: import o args;
  unstable = import inputs.nixpkgs-unstable {
    config.allowUnfree = true;
    localSystem = { inherit system; };
    overlays = with builtins; lib.pipe overlays [
      (filter (o: o != ./.))
      (map mkOverlay)
    ];
  };
in
with builtins; with lib; pipe ./. [
  findModules
  attrValues
  (map (o: import o { inherit unstable; } self super))
  (foldr recursiveUpdate { inherit unstable; })
]
