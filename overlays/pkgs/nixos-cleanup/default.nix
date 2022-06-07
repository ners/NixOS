{ lib
, writeShellApplication
, shell-utils
, ...
}:

writeShellApplication {
  name = "nixos-cleanup";
  text =
    let utilsDir = shell-utils + "/share/shell-utils";
    in
    lib.concatFiles [
      (utilsDir + "/utils.sh")
      ./nixos-cleanup.sh
    ];
}
