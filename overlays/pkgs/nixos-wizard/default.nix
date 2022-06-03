{ lib
, writeShellApplication
, shell-utils
, shellcheck
, ...
}:

writeShellApplication {
  name = "wizard";
  text =
    let utilsDir = shell-utils + "/share/shell-utils";
    in
    lib.concatFiles [
      (utilsDir + "/utils.sh")
      ./wizard.sh
    ];
  runtimeInputs = [ ];
}
