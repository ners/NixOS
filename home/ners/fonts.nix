{ pkgs, lib, ... }:

let
  gula = pkgs.stdenv.mkDerivation rec {
    name = "gula";
    nativeBuildInputs = [ pkgs.unzip ];
    src = pkgs.fetchurl {
      name = "${name}.zip";
      url = "https://dl.dafont.com/dl/?f=gula";
      sha256 = "0phk9n4v8c36841cbjl98d18yqfryp09m1rcdaqad05xqkwjkjlh";
    };
    setSourceRoot = "sourceRoot=`pwd`";
    installPhase = ''
      install -Dm644 -D "Gula FREE.otf" "$out/share/fonts/opentype/Gula.otf"
    '';
  };
in {
  # fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "Cousine"
        "FiraCode"
        "RobotoMono"
        "SourceCodePro"
      ];
    })
    agave
    charis-sil
    crimson
    gula
  ];
}
