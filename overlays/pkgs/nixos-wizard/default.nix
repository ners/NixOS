{ lib
, writeShellApplication
, shell-utils
, ...
}:

writeShellApplication {
  name = "nixos-wizard";
  text =
    let utilsDir = shell-utils + "/share/shell-utils";
    in
    lib.concatFiles [
      (utilsDir + "/utils.sh")
      ./nixos-wizard.sh
    ];
}
