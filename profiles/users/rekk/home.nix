{ pkgs, lib, ... }:

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
    ./fonts.nix
    ./git
    ./neovim
    ./skhd
    ./yabai
    ./zsh
  ];
}
