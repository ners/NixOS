{
  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    vscodeInsiders = {
      url = "github:cideM/visual-studio-code-insiders-nix";
      inputs.unstable.follows = "nixpkgs-unstable";
      inputs.flake-utils.follows = "flake-utils";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = inputs:
    let
      lib = import ./profiles/lib { inherit inputs; };
      overlays = builtins.attrValues (lib.findModules ./overlays);
    in
    {
      nixosVersion = inputs.nixpkgs-stable.lib.trivial.release;
      nixosProfiles = lib.findModules ./profiles;
      nixosRoles = lib.findModules ./roles;
      nixosConfigurations = import ./configurations {
        inherit inputs lib overlays;
      };
    } // inputs.flake-utils.lib.eachDefaultSystem (system:
      let pkgs = inputs.nixpkgs-unstable.legacyPackages.${system}; in
      {
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ nix nixfmt ];
        };
      });
}
