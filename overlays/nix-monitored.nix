{ ... }:

self: super: {
  nixos-rebuild = super.nixos-rebuild.override {
    nix = self.nix-monitored;
  };
  nix-direnv = super.nix-direnv.override {
    nix = self.nix-monitored;
  };
  nix-output-monitor = (super.writeShellApplication {
    name = "nom";
    text = ''
      exec nom "$@"
    '';
    runtimeInputs = [ super.nix super.nix-output-monitor ];
  }).overrideAttrs (_: {
    inherit (super.nix-output-monitor) name pname version;
  });
}
