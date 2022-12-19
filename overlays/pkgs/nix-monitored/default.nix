{ inputs
, lib
, stdenv
, writeShellApplication
, python3
, stdenvNoCC
, nix
, nix-output-monitor
, withNotify ? true
, libnotify
, nixos-icons
, ...
}:

let
  pname = "nix-monitored";
  nix-monitored-cpp = stdenv.mkDerivation {
    pname = "nix-monitored";
    version = nix.version;
    src = ./.;
    buildPhase = ''
      mkdir -p $out/bin
      ''${CXX} \
        ''${CXXFLAGS} \
        -std=c++11 \
        -O2 \
        -DPATH='"${nix}/bin:${nix-output-monitor}/bin"' \
        -o $out/bin/nix \
        $src/monitored.cc
    '';
    dontInstall = true;
  };
in
stdenvNoCC.mkDerivation {
  inherit (nix)
    outputs
    version
    ;
  inherit pname;
  meta = nix.meta // { mainProgram = "nix"; };
  src = nix;
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    ls ${nix} | while read d; do
      [ -e "$out/$d" ] || ln -s ${nix}/$d $out/$d
    done
    for b in nix nix-build nix-shell; do
      ln -s ${nix-monitored-cpp}/bin/nix $out/bin/$b
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

