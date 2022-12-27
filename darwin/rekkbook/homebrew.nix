{ ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "uninstall";
    };
    brews = [
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
      "displaylink"
      "displaylink-login-extension"
      "firefox"
      "google-chrome"
      "iterm2"
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
