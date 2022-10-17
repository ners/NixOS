{ lib
, writeShellApplication
, shell-utils
, nvd
, tmux
, ...
}:

writeShellApplication {
  name = "nixos-update";
  text =
    lib.concatFiles [
      shell-utils
      ./nixos-update.sh
    ];
  runtimeInputs = [ nvd tmux ];
}
