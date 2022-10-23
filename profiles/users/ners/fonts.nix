{ pkgs, lib, ... }:

let
  mkFont =
    { name
    , url
    , sha256
    , sourceRoot ? "."
    }: pkgs.stdenv.mkDerivation rec {
      inherit name;
      nativeBuildInputs = [ pkgs.unzip ];
      src = pkgs.fetchurl {
        inherit url sha256;
        name = "${name}.zip";
      };
      setSourceRoot = "sourceRoot=`pwd`";
      installPhase = ''
        for f in ${sourceRoot}/*.ttf; do
          install -Dm644 -D "$f" "$out/share/fonts/truetype/${name}/$f"
        done
        for f in ${sourceRoot}/*.otf; do
          install -Dm644 -D "$f" "$out/share/fonts/opentype/${name}/$f"
        done
      '';
    };
  oswald = mkFont {
    name = "oswald";
    url = "https://www.fontsquirrel.com/fonts/download/oswald";
    sha256 = "sha256-GllqwB39rzIz+bsatfGFjqa7LIQ5Ex70IjDvpe8RdmY=";
  };
  gula = mkFont {
    name = "gula";
    url = "https://dl.dafont.com/dl/?f=gula";
    sha256 = "sha256-kMop+cS9gKawaiyHmsD12WGPQkOJysUCQWYwtIlNE14=";
  };
  playfair = mkFont {
    name = "playfair";
    url = "https://github.com/clauseggers/Playfair/archive/refs/heads/master.zip";
    sha256 = "sha256-TBrX49OJleicgZxdC12ywMr/Dsd06/uQloZuSPGaDAk=";
    sourceRoot = "Playfair-master/fonts/VF-TTF";
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
    playfair
  ];
}
