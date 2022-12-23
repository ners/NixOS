{ inputs
, writeShellApplication
, shell-utils
, nix
, nixos-rebuild
, nvd
, tmux
, systemd
, ...
}:

writeShellApplication {
  name = "nixos-update";
  text =
    inputs.lib.concatFiles [
      shell-utils
      ./nixos-update.sh
    ];
  runtimeInputs = [
    nix
    nixos-rebuild
    nvd
    tmux
    systemd
  ];
}
