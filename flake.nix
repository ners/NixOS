{
  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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
      overlaySrcs = builtins.attrValues (lib.findModules ./overlays);
      mkOverlay = o: import o {
        inherit lib inputs;
        overlays = overlaySrcs;
      };
      overlays = map mkOverlay overlaySrcs;
    in
    {
      version = inputs.nixpkgs-stable.lib.trivial.release;
      profiles = lib.findModules ./profiles;
      roles = lib.findModules ./roles;
      nixosConfigurations = import ./nixos {
        inherit inputs lib overlays;
      };
      darwinConfigurations = import ./darwin {
        inherit inputs lib overlays;
      };
    } // inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs-stable { inherit system overlays; };
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs.unstable; [ nix-monitored nixfmt ];
        };
        packages = pkgs // {
          iso-image = inputs.self.nixosConfigurations.iso-image.config.system.build.isoImage;
        };
      });
}
