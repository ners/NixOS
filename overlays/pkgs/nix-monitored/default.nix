{ inputs
, lib
, writeShellApplication
, stdenvNoCC
, runtimeShell
, nix
, nix-output-monitor
, ...
}:

let
  nix-monitored-script = (writeShellApplication {
    name = "nix-monitored";
    runtimeInputs = [ nix nix-output-monitor ];
    text = ''
      command="$(basename "$0")"
      if ! [ -t 2 ]; then
      	exec "$command" "$@"
      fi

      verb="$1"
      shift
      case "$verb" in
      	run)
      		nom build --no-link "$@"
      		exec nix "$verb" "$@"
      		;;
      	repl|flake)
      		exec nix "$verb" "$@"
      		;;
      	build|shell|develop)
      		exec nom "$verb" "$@"
      		;;
      esac
      exec "$command" "$verb" "$@" 2> >(nom 1>&2)
    '';
  }).overrideAttrs (attrs: rec {
    inherit (nix) version;
    pname = attrs.name;
    name = "${pname}-${version}";
  });
in
stdenvNoCC.mkDerivation {
  inherit (nix)
    meta
    outputs
    version
    ;
  pname = "nix-monitored";
  src = nix;
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    ls ${nix} | while read d; do
      [ -e "$out/$d" ] || ln -s ${nix}/$d $out/$d
    done
    for b in nix nix-build nix-shell; do
      ln -s ${nix-monitored-script}/bin/nix-monitored $out/bin/$b
    done
    ls ${nix}/bin | while read b; do
      [ -e $out/bin/$b ] || ln -s ${nix}/bin/$b $out/bin/$b
    done
    ${ with builtins; with inputs.lib; pipe
        nix.outputs
        [
          (map (o: ''
            [ -e "''$${o}" ] || ln -s ${nix.${o}} ''$${o}
          ''))
          unlines
        ]
    }
  '';
}

