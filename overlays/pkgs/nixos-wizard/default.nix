{ lib
, writeShellApplication
, shell-utils
, gptfdisk
, git
, jq
, ...
}:

writeShellApplication {
  name = "nixos-wizard";
  text =
    lib.concatFiles [
      shell-utils
      ./nixos-wizard.sh
    ];
  runtimeInputs = [ gptfdisk git jq ];
}
