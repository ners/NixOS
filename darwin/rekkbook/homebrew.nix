{ ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "uninstall";
    };
    brews = [
      "briss"
      "mailcatcher"
      {
        name = "yabai";
        start_service = true;
        restart_service = true;
      }
      {
        name = "skhd";
        start_service = true;
        restart_service = true;
      }
    ];
    casks = [
      "1password"
      "blender"
      "calibre"
      "darktable"
      "discord"
      "displaylink"
      "displaylink-login-extension"
      "element"
      "fastrawviewer"
      "firefox-developer-edition"
      "google-chrome"
      "iina"
      "iterm2"
      "lycheeslicer"
      "neovide"
      "obsidian"
      "plexamp"
      "preform"
      "prusaslicer"
      "qfinder-pro"
      "shutter-encoder"
      "slack"
      "teamviewer"
      "telegram-desktop"
      "tunnelblick"
      "transmission"
      "ultimaker-cura"
      "uvtools"
      "vimr"
      "virtualbox-beta"
      "visual-studio-code"
      "vlc"
      "vnc-viewer"
      "wine-stable"
      "zoom"
    ];
    taps = [
      "homebrew/cask-drivers"
      "homebrew/cask-versions"
      "koekeishiya/formulae"
    ];
  };
}
