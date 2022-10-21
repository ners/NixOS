{ python3Packages, grim }:

python3Packages.buildPythonPackage rec {
  name = "assign-cgroups";

  src = [ ./assign-cgroups ./setup.py ];

  unpackPhase = ''
    for srcFile in $src; do
    	cp $srcFile $(stripHash $srcFile)
    done
  '';
  installPhase = ''
    install -Dm 0755 assign-cgroups $out/bin/assign-cgroups
  '';

  dontConfigure = true;

  propagatedBuildInputs = with python3Packages; [ dbus-next i3ipc psutil tenacity xlib ];
}
