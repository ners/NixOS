{ inputs, pkgs, lib, ... }:

{
  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
      preallocate-contents = false
      keep-outputs = true
      keep-derivations = true
    '';
  };
}
