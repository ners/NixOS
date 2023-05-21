{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cmake
    comma
    dotnet-runtime
    ffmpeg
    ncdu
    tailscale
    mpv
  ];

  imports = [
    ./git
    ./fonts.nix
    ./neovim
    ./skhd
    ./yabai
    ./zsh
  ];
}
