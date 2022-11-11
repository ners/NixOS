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
    nom=${nix-output-monitor}/bin/nom
    echo nix | while read b; do
    command=${nix}/bin/$b
    cat << EOF > $out/bin/$b
    #!${runtimeShell}
    ${builtins.readFile ./monitored.sh}
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

