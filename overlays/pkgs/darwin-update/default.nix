{ inputs
, writeShellApplication
, shell-utils
, nix
, darwin-rebuild
, nvd
, tmux
, systemd
, ...
}:

writeShellApplication {
  name = "darwin-update";
  text =
    inputs.lib.concatFiles [
      shell-utils
      ./darwin-update.sh
    ];
  runtimeInputs = [
    nix
    darwin-rebuild
    nvd
    tmux
  ];
}
