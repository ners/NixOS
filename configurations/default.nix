{ lib, inputs, overlays, ... }:

with inputs;
with builtins;

lib.pipe ./. [
  lib.findModules
  (mapAttrs (name: path:
    let
      system = with lib; pipe (path + "/system") [ readFile lines head ];
      mkOverlay = o: import o { inherit lib inputs system; };
      pkgs = import nixpkgs-stable {
        localSystem = { inherit system; };
        overlays = map mkOverlay overlays;
      };
    in
    lib.nixosSystem {
      inherit system;
      modules = [
        {
          system.stateVersion = self.nixosVersion;
          networking.hostName = lib.mkDefault name;
          nixpkgs = { inherit pkgs; };
        }
        (import path)
      ];
      specialArgs = { inherit lib inputs; };
      extraArgs = { flake = self; };
    }
  ))
]
