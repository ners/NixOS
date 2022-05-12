{ lib
, stdenv
, wine
, makeDesktopItem
, writeScriptBin
}:

stdenv.mkDerivation rec {
  pname = "winbox";
  version = "3.35";

  srcs = [
    (builtins.fetchurl {
      url = "https://download.mikrotik.com/winbox/${version}/winbox.exe";
      sha256 = "01w0g7fp7grgrsa78mzjmmxjy8bld6zmybjn87arz5j9ki9s48nb";
    })
    (./winbox.svg)
    (./winbox.png)
  ];

  winboxItem = makeDesktopItem {
    name = "winbox";
    exec = "winbox";
    icon = "winbox";
    comment = meta.description;
    desktopName = "WinBox";
    genericName = "Router Configurator";
    categories = "Network";
  };

  winboxScript = writeScriptBin "winbox" ''
    exec ${wine}/bin/wine @out@/opt/winbox.exe
  '';

  unpackPhase = ''
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

  meta = with lib; {
    homepage = "https://mikrotik.com/software";
    description =
      "A small utility that allows administration of MikroTik RouterOS using a fast and simple GUI.";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = with maintainers; [ ners ];
  };
}
