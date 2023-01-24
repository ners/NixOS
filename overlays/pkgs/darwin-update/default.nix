{ inputs
, writeShellApplication
, shell-utils
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
    darwin-rebuild
    nvd
    tmux
  ];
}
