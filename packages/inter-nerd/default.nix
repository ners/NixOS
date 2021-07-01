with import <nixpkgs> { };

pkgs.stdenv.mkDerivation rec {
  name = "inter-nerd";

  src = ./.;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    install -Dm755 ./Inter\ Regular\ Nerd\ Font.otf $out/share/fonts/opentype/
  '';

  meta = with lib; {
    homepage = "https://rsms.me/inter/";
    description = "A typeface specially designed for user interfaces";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = with maintainers; [ ners ];
  };
}
