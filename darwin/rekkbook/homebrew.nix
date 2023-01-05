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
      "darktable"
      "discord"
      "displaylink"
      "displaylink-login-extension"
      "firefox"
      "google-chrome"
      "iterm2"
      "lycheeslicer"
      "plexamp"
      "prusaslicer"
      "slack"
      "telegram-desktop"
      "vimr"
    ];
    taps = [
      "homebrew/cask-drivers"
      "koekeishiya/formulae"
    ];
  };
}
