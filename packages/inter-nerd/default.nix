with import <nixpkgs> { };

pkgs.stdenv.mkDerivation rec {
  name = "inter-nerd";

  src = ./.;

  installPhase = ''
    install -Dm644 ./InterRegularNerd.otf $out/share/fonts/opentype/InterRegularNerd.otf
  '';

  meta = with lib; {
    homepage = "https://rsms.me/inter/";
    description = "A typeface specially designed for user interfaces";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = with maintainers; [ ners ];
  };
}
