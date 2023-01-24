{ inputs
, lib
, substituteAll
, runtimeShell
}:

let
  writeProgram = name: env: src:
    substituteAll ({
      inherit name src;
      dir = "bin";
      isExecutable = true;
    } // env);
in
substituteAll {
  name = "darwin-rebuild";
  src = "${inputs.nix-darwin}/pkgs/nix-tools/darwin-rebuild.sh";
  dir = "bin";
  isExecutable = true;
  shell = runtimeShell;
  profile = "";
}
