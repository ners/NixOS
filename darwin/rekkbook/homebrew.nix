{ ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "uninstall";
    };
    brews = [
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
      "slack"
      "teamviewer"
      "telegram-desktop"
      "tunnelblick"
      "ultimaker-cura"
      "uvtools"
      "vimr"
      "virtualbox-beta"
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
