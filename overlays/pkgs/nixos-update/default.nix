{ inputs
, writeShellApplication
, shell-utils
, nixos-rebuild
, nvd
, tmux
, systemd
, dbus
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
    nixos-rebuild
    nvd
    tmux
    systemd
    dbus
  ];
}
