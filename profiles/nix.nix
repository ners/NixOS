{ inputs, pkgs, lib, ... }:

lib.mkMerge [
  {
    nix = {
      settings = {
        auto-optimise-store = true;
        trusted-users = [ "root" "@wheel" "@admin" ];
      };
      gc = {
        automatic = true;
        options = "--delete-older-than 30d";
      };
      package = pkgs.unstable.nix-monitored;
      registry.nixpkgs.flake = inputs.nixpkgs-unstable;
      nixPath = [ "nixpkgs=/etc/channels/nixpkgs" ];
      extraOptions = ''
        experimental-features = nix-command flakes ca-derivations
        preallocate-contents = false
        #keep-outputs = true
        #keep-derivations = true
      '';
    };
    environment.etc."channels/nixpkgs".source = inputs.nixpkgs-unstable.outPath;
  }
  (lib.optionalAttrs pkgs.stdenv.isLinux {
    nix.gc.dates = "monthly";
  })
  (lib.optionalAttrs pkgs.stdenv.isDarwin {
    nix.gc.interval.Day = 1;
    services.nix-daemon.enable = true;
  })
]
