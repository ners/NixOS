{ lib, inputs, overlays, ... }:

with inputs;
with builtins;

lib.pipe ./. [
  lib.findModules
  (mapAttrs (name: path:
    let
      system = with lib; pipe (path + "/system") [ readFile lines head ];
      pkgs = import nixpkgs-unstable { inherit system overlays; };
    in
    lib.nixosSystem {
      inherit system;
      modules = [
        {
          system.stateVersion = inputs.self.version;
          networking.hostName = lib.mkDefault name;
          nixpkgs = { inherit pkgs; };
        }
        inputs.home-manager.nixosModules.default
        inputs.nix-monitored.nixosModules.${system}.default
        path
      ];
      specialArgs = {
        inherit inputs pkgs lib;
      };
    }
  ))
]
