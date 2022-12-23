{ ... }:

{
  homebrew = {
    enable = true;
    onActivation = { autoUpdate = false; };
    brews = [
      {
        name = "yabai";
        start_service = true;
        restart_service = "changed";
      }
      {
        name = "skhd";
        start_service = true;
        restart_service = "changed";
      }
    ];
    casks = [
      "iterm2"
      "firefox"
    ];
    taps = [
      "koekeishiya/formulae"
    ];
  };
}
