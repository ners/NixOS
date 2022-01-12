{ stdenv
, writeShellApplication
, nvd
}:

writeShellApplication {
  name = "nixos-update";
  text = builtins.readFile ./nixos-update.sh;
  runtimeInputs = [ nvd ];
}
