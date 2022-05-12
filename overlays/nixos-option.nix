{ inputs, ... }:

# Make nixos-option work with flakes
self: super: {
  nixos-option =
    let
      prefix = ''(import ${inputs.flake-compat} { src = /etc/nixos; }).defaultNix.nixosConfigurations.\$(hostname)'';
    in
    super.runCommandNoCC "nixos-option" { buildInputs = [ super.makeWrapper ]; } ''
      makeWrapper ${super.nixos-option}/bin/nixos-option $out/bin/nixos-option \
        --add-flags --config_expr \
        --add-flags "\"${prefix}.config\"" \
        --add-flags --options_expr \
        --add-flags "\"${prefix}.options\""
    '';
}
