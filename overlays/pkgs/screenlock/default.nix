{ python3Packages
, grim
, ...
}:

python3Packages.buildPythonApplication {
  name = "screenlock";
  format = "other";

  src = ./.;

  installPhase = ''
    runHook preInstall
    install -Dm 0755 screenlock $out/bin/screenlock
    runHook postInstall
  '';

  propagatedBuildInputs = with python3Packages; [ i3ipc pillow grim ];
}
