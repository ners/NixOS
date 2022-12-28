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
        find ${sourceRoot} -type f -name '*.ttf' | while read f; do
          echo installing "$f" to "/share/fonts/truetype/${name}/$(basename $f)"
          install -Dm644 -D "$f" "$out/share/fonts/truetype/${name}/$(basename $f)"
        done
        find ${sourceRoot} -type f -name '*.otf' | while read f; do
          echo installing "$f" to "/share/fonts/opentype/${name}/$(basename $f)"
          install -Dm644 -D "$f" "$out/share/fonts/opentype/${name}/$(basename $f)"
        done
      '';
    };
  oswald = mkFont {
    name = "oswald";
    url = "https://github.com/googlefonts/OswaldFont/archive/refs/heads/main.zip";
    sha256 = "sha256-I0qJXb7dW6Hz77YwgUVxwy6c5ry4cnkj6Sqmb1Wcu1w=";
    sourceRoot = "OswaldFont-main/fonts";
  };
  radley = mkFont {
    name = "radley";
    url = "https://github.com/googlefonts/RadleyFont/archive/refs/heads/main.zip";
    sha256 = "sha256-HLxKHfpwPU9WH0ir/Hm3eURZTBB9nn/MfDSwvqYwRDY=";
    sourceRoot = "RadleyFont-main/fonts";
  };
  gula = mkFont {
    name = "gula";
    url = "https://www.fontriver.com/f/gula.zip";
    sha256 = "sha256-kMop+cS9gKawaiyHmsD12WGPQkOJysUCQWYwtIlNE14=";
  };
  bluetea = mkFont {
    name = "bluetea";
    url = "https://www.fontriver.com/f/bluetea.zip";
    sha256 = "sha256-jl5JKfJrUyYxGLEgyQccd2xB0wSVy15aMGZVXkwMClc=";
  };
  playfair = mkFont {
    name = "playfair";
    url = "https://github.com/clauseggers/Playfair/archive/refs/heads/master.zip";
    sha256 = "sha256-j+xciORyOuV993D5d7DnFnaI7oX3S4noVn8NQda39kA=";
    sourceRoot = "Playfair-master/fonts/VF-TTF";
  };
  along-sans = mkFont {
    name = "along-sans";
    url = "https://dl.dafont.com/dl/?f=along_sans";
    sha256 = "sha256-3rixZaoWlQaNBIjDUEdGMkrx8Z1rln7ueno60hA1mYw=";
  };
in
{
  fonts.fontconfig.enable = lib.mkForce true;
  home.packages = with pkgs; [
    along-sans
    agave
    bluetea
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
    radley
  ];
}
