{ lib, inputs, overlays, ... }:

with builtins;

lib.pipe ./. [
  lib.findModules
  (mapAttrs (name: path:
    let
      system = with lib; pipe (path + "/system") [ readFile lines head ];
      pkgs = import inputs.nixpkgs-stable { inherit system overlays; };
    in
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        inputs.home-manager.darwinModule
        path
      ];
      specialArgs = {
        inherit pkgs lib;
        inputs = inputs // {
          nixpkgs = inputs.nixpkgs-unstable;
          darwin = inputs.nix-darwin;
        };
      };
    }
  ))
]
