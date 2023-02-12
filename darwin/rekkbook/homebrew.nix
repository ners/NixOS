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
      "firefox"
      "google-chrome"
      "iterm2"
      "lycheeslicer"
      "obsidian"
      "plexamp"
      "preform"
      "prusaslicer"
      "slack"
      "telegram-desktop"
      "ultimaker-cura"
      "uvtools"
      "vimr"
    ];
    taps = [
      "homebrew/cask-drivers"
      "koekeishiya/formulae"
    ];
  };
}
