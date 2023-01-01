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
      "discord"
      "darktable"
      "displaylink"
      "displaylink-login-extension"
      "firefox"
      "google-chrome"
      "iterm2"
      "prusaslicer"
      "slack"
      "telegram-desktop"
      "vimr"
      "lycheeslicer"
    ];
    taps = [
      "homebrew/cask-drivers"
      "koekeishiya/formulae"
    ];
  };
}
