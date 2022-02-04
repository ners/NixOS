{ stdenv
, lib
, ...
}:

stdenv.mkDerivation rec {
  name = "shell-utils";
  version = "0.0.1";
  src = ./.;
  installPhase = ''
    for script in ./*.sh; do
      install -Dm644 $script $out/share/${name}/$script
    done
  '';

  meta = with lib; {
    homepage = "https://github.com/ners/NixOS";
    description = "A collection of utility functions for shell scripting";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ ners ];
  };
}
