{ writeScriptBin, ... }:

writeScriptBin "wizard" (builtins.readFile ./wizard.sh)
