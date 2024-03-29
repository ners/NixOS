{ inputs, pkgs, lib, ... }:

lib.mkMerge [
  {
    nix = {
      settings = {
        auto-optimise-store = true;
        preallocate-contents = false;
        experimental-features = [ "nix-command" "flakes" "ca-derivations" ];
        trusted-users = [ "root" "@wheel" "@admin" ];
      };
      gc = {
        automatic = true;
        options = "--delete-older-than 30d";
      };
      monitored = {
        enable = true;
        package = pkgs.unstable.nix-monitored;
      };
      registry.nixpkgs.flake = inputs.nixpkgs-unstable;
      nixPath = [ "nixpkgs=/etc/channels/nixpkgs" ];
    };
    environment.etc."channels/nixpkgs".source = inputs.nixpkgs-unstable.outPath;
  }
  (lib.optionalAttrs pkgs.parsedSystem.isLinux {
    nix.gc.dates = "monthly";
  })
  (lib.optionalAttrs pkgs.parsedSystem.isDarwin {
    nix.gc.interval.Day = 1;
    services.nix-daemon.enable = true;
  })
]
