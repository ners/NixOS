{ pkgs, lib, ... }:

let
  mkFont = { name, url, sha256 }: pkgs.stdenv.mkDerivation rec {
    inherit name;
    nativeBuildInputs = [ pkgs.unzip ];
    src = pkgs.fetchurl {
      inherit url sha256;
      name = "${name}.zip";
    };
    setSourceRoot = "sourceRoot=`pwd`";
    installPhase = ''
      for f in *.ttf; do
        install -Dm644 -D "$f" "$out/share/fonts/truetype/${name}/$f"
      done
      for f in *.otf; do
        install -Dm644 -D "$f" "$out/share/fonts/opentype/${name}/$f"
      done
    '';
  };
  oswald = mkFont {
    name = "oswald";
    url = "https://www.fontsquirrel.com/fonts/download/oswald";
    sha256 = "sha256-+E/XVTPLKA6zKa+QZ/IrPp0RjLNEKf5WOO63oXGrROk=";
  };
  gula = mkFont {
    name = "gula";
    url = "https://dl.dafont.com/dl/?f=gula";
    sha256 = "sha256-kMop+cS9gKawaiyHmsD12WGPQkOJysUCQWYwtIlNE14=";
  };
in
{
  fonts.fontconfig.enable = lib.mkForce true;
  home.packages = with pkgs; [
    agave
    charis-sil
    crimson
    eb-garamond
    gula
    hasklig
    material-design-icons
    monoid
    oswald
    paratype-pt-mono
    paratype-pt-sans
    paratype-pt-serif
  ];
}
