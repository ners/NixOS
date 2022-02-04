{ pkgs, lib, ... }:

let
  toYAML = args: pkgs.stdenv.mkDerivation {
    name = "toYAML";
    buildInputs = [ pkgs.haskellPackages.json2yaml ];
    src = pkgs.writeText "out.yaml" (builtins.toJSON args);
    buildCommand = ''
      json2yaml $src > $out
    '';
  };
in
{
  home.packages = [ pkgs.yambar ];

  wayland.windowManager.sway.config.bars = [
    { command = "yambar"; }
  ];

  #xdg.configFile."yambar/config.yml".text = (toYAML {
  #  bar = {
  #    height = 30;
  #    location = "bottom";
  #    background = "000000ff";
  #  };
  #}).out;
  xdg.configFile."yambar/config.yml".text = ''
    bar:
      height: 26
      location: top
      background: 000000ff

      right:
        - clock:
            content:
              - string: {text: , font: "Font Awesome 5 Free:style=solid:size=12"}
              - string: {text: "{date}", right-margin: 5}
              - string: {text: , font: "Font Awesome 5 Free:style=solid:size=12"}
              - string: {text: "{time}"}
  '';
}
