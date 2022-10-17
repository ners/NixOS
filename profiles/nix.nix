{ inputs, pkgs, ... }:

{
  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };
    package = pkgs.unstable.nix;
    registry.nixpkgs.flake = inputs.nixpkgs-unstable;
    nixPath = [ "nixpkgs=/etc/channels/nixpkgs" ];
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
      preallocate-contents = false
      #keep-outputs = true
      #keep-derivations = true
    '';
    trustedUsers = [ "root" "@wheel" ];
  };
  environment.etc."channels/nixpkgs".source = inputs.nixpkgs-unstable.outPath;
}
