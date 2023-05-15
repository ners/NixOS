{ pkgs, lib, ... }:

let
  mkFont =
    { name
    , url
    , hash
    , sourceRoot ? "."
    }: pkgs.stdenv.mkDerivation rec {
      inherit name;
      nativeBuildInputs = [ pkgs.unzip ];
      src = pkgs.fetchurl {
        inherit url hash;
        name = "${name}.zip";
      };
      setSourceRoot = "sourceRoot=`pwd`";
      installPhase = ''
        find ${sourceRoot} -type f -name '*.ttf' | while read f; do
          d="$out/share/fonts/truetype/${name}/$(basename "$f")"
          echo "installing $f to $d"
          install -Dm644 -D "$f" "$d"
        done
        find ${sourceRoot} -type f -name '*.otf' | while read f; do
          d="$out/share/fonts/opentype/${name}/$(basename "$f")"
          echo "installing $f to $d"
          install -Dm644 -D "$f" "$d"
        done
      '';
    };
  nerdify = { font, file ? "", mono ? false }:
    pkgs.stdenvNoCC.mkDerivation rec {
      name = "${font.name}-nerd";
      src = pkgs.fetchFromGitHub {
        owner = "ryanoasis";
        repo = "nerd-fonts";
        rev = "v2.3.3";
        hash = "sha256-42gG0jV7TunD/MoTxSSkXniLW5/X1pHwQwzK05TCMBE=";
      };
      buildInputs = with pkgs; [
        argparse
        fontforge
        (python3.withPackages (ps: with ps; [ setuptools fontforge ]))
      ];
      buildPhase = ''
        find ${font}/${file} -type f -name '*.ttf' -or -name '*.otf' | while read f; do
          echo "nerdifying $f"
          python3 "$src/font-patcher" --complete ${if mono then "--mono" else ""} "$f"
        done
      '';
      installPhase = ''
        for f in *.ttf; do
          d="$out/share/fonts/truetype/${name}/$f"
          echo "installing $f to $d"
          install -Dm644 -D "$f" "$d"
        done
        for f in *.otf; do
          d="$out/share/fonts/opentype/${name}/$f"
          echo "installing $f to $d"
          install -Dm644 -D "$f" "$d"
        done
      '';
    };
  oswald = mkFont {
    name = "oswald";
    url = "https://github.com/googlefonts/OswaldFont/archive/refs/heads/main.zip";
    hash = "sha256-zd7eW7+ni6swa3qhh3R4ADPapxH+9sLAJOKnyviSZEM=";
    sourceRoot = "OswaldFont-main/fonts";
  };
  radley = mkFont {
    name = "radley";
    url = "https://github.com/googlefonts/RadleyFont/archive/refs/heads/main.zip";
    hash = "sha256-HLxKHfpwPU9WH0ir/Hm3eURZTBB9nn/MfDSwvqYwRDY=";
    sourceRoot = "RadleyFont-main/fonts";
  };
  gula = mkFont {
    name = "gula";
    url = "https://www.fontriver.com/f/gula.zip";
    hash = "sha256-kMop+cS9gKawaiyHmsD12WGPQkOJysUCQWYwtIlNE14=";
  };
  bluetea = mkFont {
    name = "bluetea";
    url = "https://www.fontriver.com/f/bluetea.zip";
    hash = "sha256-jl5JKfJrUyYxGLEgyQccd2xB0wSVy15aMGZVXkwMClc=";
  };
  playfair = mkFont {
    name = "playfair";
    url = "https://github.com/clauseggers/Playfair/archive/refs/heads/master.zip";
    hash = "sha256-9jSTYo76g/15gYQhPWJRWHDlZ3Abp/WjESEPFYileMA=";
    sourceRoot = "Playfair-master/fonts/VF-TTF";
  };
  along-sans = mkFont {
    name = "along-sans";
    url = "https://dl.dafont.com/dl/?f=along_sans";
    hash = "sha256-3rixZaoWlQaNBIjDUEdGMkrx8Z1rln7ueno60hA1mYw=";
  };
  new-heterodox-mono = mkFont {
    name = "new-heterodox-mono";
    url = "https://github.com/hckiang/font-new-heterodox-mono/archive/refs/heads/master.zip";
    hash = "sha256-oXEGF77bEBkmsz0tzMvTk+V9RHw1hVhL9zHqh8BPdhE=";
  };
  iosevka-term = pkgs.iosevka.override {
    set = "term";
    privateBuildPlan = {
      family = "Iosevka Term";
      design = [
        "term"
        "v-l-italic"
        "v-i-italic"
        "v-g-singlestorey"
      ];
    };
  };
in
{
  fonts.fontconfig.enable = lib.mkForce true;
  home.packages = with pkgs; [
    (nerdify { font = inter; file = "share/fonts/opentype/Inter-Regular.otf"; })
    (nerdify { font = iosevka-term; file = "share/fonts/truetype/iosevka-term-extendedlight.ttf"; mono = true; })
    (nerdify { font = new-heterodox-mono; file = "share/fonts/opentype/new-heterodox-mono/NewHeterodoxMono-Book.otf"; mono = true; })
    agave
    along-sans
    bluetea
    charis-sil
    crimson
    eb-garamond
    gula
    hasklig
    material-design-icons
    monoid
    new-heterodox-mono
    oswald
    paratype-pt-mono
    paratype-pt-sans
    paratype-pt-serif
    playfair
    radley
  ];
}
