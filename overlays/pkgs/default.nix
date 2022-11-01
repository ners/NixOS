{ inputs, lib, ... }:

self: super:
with lib; pipe ./. [
  findModules
  (mapAttrs (name: package:
    super.callPackage package { inputs = inputs // { inherit lib; }; }
  ))
]
