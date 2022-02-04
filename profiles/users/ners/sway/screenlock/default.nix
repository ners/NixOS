{ python3Packages, grim }:

python3Packages.buildPythonPackage rec {
  name = "screenlock";

  src = [ ./screenlock ./setup.py ];

  unpackPhase = ''
    for srcFile in $src; do
    	cp $srcFile $(stripHash $srcFile)
    done
  '';
  installPhase = ''
    install -Dm 0755 screenlock $out/bin/screenlock
  '';

  dontConfigure = true;

  propagatedBuildInputs = with python3Packages; [ i3ipc pillow grim ];
}
