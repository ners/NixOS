{ lib
, writeShellApplication
, writeText
, tmux
, ...
}:

let
  app = writeShellApplication {
    name = "shell-utils";
    text = builtins.readFile ./utils.sh;
    runtimeInputs = [ tmux ];
  };
in
writeText "shell-utils" ''
  # shellcheck disable=SC1091
  source ${app}/bin/${app.name}
''
