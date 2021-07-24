with import <nixpkgs> { };

pkgs.stdenv.mkDerivation rec {
  pname = "winbox";
  version = "3.28";

  srcs = [
    (fetchurl {
      url = "https://download.mikrotik.com/winbox/${version}/winbox.exe";
      sha256 = "04f2kg7m3qwd7x0i3w9x01jjd8raznaba701vbx20zhyvfawl6kg";
    })
    (./winbox.svg)
    (./winbox.png)
  ];

  winboxItem = pkgs.makeDesktopItem {
    name = "winbox";
    exec = "winbox";
    icon = "winbox";
    comment = meta.description;
    desktopName = "WinBox";
    genericName = "Router Configurator";
    categories = "Network";
  };

  winboxScript = pkgs.writeScriptBin "winbox" ''
    #!${pkgs.stdenv.shell}
    exec ${pkgs.wine}/bin/wine @out@/opt/winbox.exe
  '';

  unpackPhase = ''
    echo srcs is $srcs
    for srcFile in $srcs; do
      cp $srcFile $(stripHash $srcFile)
    done
  '';

  installPhase = ''
    install -Dm 0755 winbox.exe $out/opt/winbox.exe
    install -Dm 0755 ${winboxScript}/bin/winbox $out/bin/winbox
    substituteAllInPlace $out/bin/winbox
    install -D ${winboxItem}/share/applications/winbox.desktop $out/share/applications/winbox.desktop
    install -D winbox.svg $out/share/icons/hicolor/scalable/apps/winbox.svg
    install -D winbox.png $out/share/icons/hicolor/512x512/apps/winbox.png
  '';

  nativeBuildInputs = with pkgs; [ wine winboxScript ];

  meta = with lib; {
    homepage = "https://mikrotik.com/software";
    description =
      "A small utility that allows administration of MikroTik RouterOS using a fast and simple GUI.";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = with maintainers; [ ners ];
  };
}
