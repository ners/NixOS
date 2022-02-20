{
  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs = inputs:
    let
      lib = import ./profiles/lib { inherit inputs; };
      overlays = builtins.attrValues (lib.findModules ./overlays);
      system = lib.attrByPath [ "currentSystem" ] "x86_64-linux" builtins;
      pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosVersion = inputs.nixpkgs-stable.lib.trivial.release;
      nixosProfiles = lib.findModules ./profiles;
      nixosRoles = lib.findModules ./roles;
      nixosConfigurations = import ./configurations {
        inherit inputs lib overlays;
      };
      devShell.${system} = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [ nix nixfmt ];
      };
    };
}
