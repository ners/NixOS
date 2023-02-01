{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cmake
    dotnet-runtime
    ffmpeg
    tailscale
#    (difftastic.overrideAttrs (_: { version = "0.42.0"; }))
  ];

  imports = [
    ./git
    ./neovim
    ./skhd
    ./yabai
    ./zsh
  ];
}
