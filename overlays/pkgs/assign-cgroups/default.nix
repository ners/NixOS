{ python3Packages
, grim
, ...
}:

python3Packages.buildPythonApplication {
  name = "assign-cgroups";
  format = "other";

  src = ./.;

  installPhase = ''
    runHook preInstall
    install -Dm 0755 assign-cgroups $out/bin/assign-cgroups
    runHook postInstall
  '';

  propagatedBuildInputs = with python3Packages; [ dbus-fast i3ipc psutil tenacity xlib ];
}
