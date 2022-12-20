{ inputs
, writeShellApplication
, shell-utils
, nix-output-monitor
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
    nix-output-monitor
    nvd
    tmux
    systemd
  ];
}
