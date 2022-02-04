{ lib, inputs, overlays, ... }:

with inputs;
with builtins;

let
  configurations = attrNames (lib.findModules ./.);
  mkSystem = name:
    let
      system = with lib; pipe ./${name}/system [ readFile lines head ];
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
          nixpkgs.pkgs = pkgs;
        }
        (import ./${name})
      ];
      specialArgs = { inherit lib inputs; };
    };
in
lib.genAttrs configurations mkSystem
