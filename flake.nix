{
  inputs = {
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
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
    in
    {
      nixosVersion = lib.trivial.release;
      nixosProfiles = lib.findModules ./profiles;
      nixosRoles = lib.findModules ./roles;
      nixosConfigurations = import ./configurations {
        inherit lib inputs overlays;
      };
    };
}
