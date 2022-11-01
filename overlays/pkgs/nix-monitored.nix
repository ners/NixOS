{ inputs
, stdenvNoCC
, runtimeShell
, nix
, nix-output-monitor
, ...
}:

stdenvNoCC.mkDerivation {
  inherit (nix)
    debug
    man
    meta
    name
    outputs
    pname
    version
    ;
  src = nix;
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    ls ${nix} | while read d; do
      [ -e "$out/$d" ] || ln -s ${nix}/$d $out/$d
    done
    echo nix | while read b; do
    cat << EOF > $out/bin/$b
      #!${runtimeShell}
      if [ -t 1 ] && [ "\$1" != repl ]; then
        exec ${nix}/bin/$b "\$@" |& ${nix-output-monitor}/bin/nom
      else
        exec ${nix}/bin/$b "\$@"
      fi
    EOF
    chmod +x $out/bin/$b
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
