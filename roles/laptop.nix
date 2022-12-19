{ inputs, pkgs, options, ... }:

{
  imports = with inputs.self; [
    roles.nixos
  ];

  environment.systemPackages = with pkgs; [
    acpi
  ];
}
