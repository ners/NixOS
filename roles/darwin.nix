{ inputs, pkgs, ... }:

{
  imports = with inputs; [
    self.roles.base
    self.profiles.fonts
  ];

  environment.systemPackages = with pkgs; [
    darwin-update
    iterm2
  ];
}
