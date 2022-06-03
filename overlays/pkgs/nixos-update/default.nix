{ lib
, writeShellApplication
, shell-utils
, shellcheck
, nvd
, ...
}:

writeShellApplication {
  name = "nixos-update";
  text =
    let utilsDir = shell-utils + "/share/shell-utils";
    in
    lib.concatFiles [
      (utilsDir + "/utils.sh")
      ./nixos-update.sh
    ];
  runtimeInputs = [ nvd ];
}
