{ lib, inputs, overlays, ... }:

with inputs;
with builtins;

lib.pipe ./. [
  lib.findModules
  (mapAttrs (name: path:
    let
      system = with lib; pipe (path + "/system") [ readFile lines head ];
      pkgs = import nixpkgs-stable { inherit system overlays; };
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
      specialArgs = { inherit inputs pkgs lib; };
    }
  ))
]
