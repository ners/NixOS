{ config, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = with config.colorScheme.colors; ''
      # COLOUR (base16)

      # default statusbar colors
      set-option -g status-style "fg=#${base04},bg=#${base01}"

      # default window title colors
      set-window-option -g window-status-style "fg=#${base04},bg=default"

      # active window title colors
      set-window-option -g window-status-current-style "fg=#${base0A},bg=default"

      # pane border
      set-option -g pane-border-style "fg=#${base01}"
      set-option -g pane-active-border-style "fg=#${base02}"

      # message text
      set-option -g message-style "fg=#${base05},bg=#${base01}"

      # pane number display
      set-option -g display-panes-active-colour "#${base0B}"
      set-option -g display-panes-colour "#${base0A}"

      # clock
      set-window-option -g clock-mode-colour "#${base0B}"

      # copy mode highligh
      set-window-option -g mode-style "fg=#${base04},bg=#${base02}"

      # bell
      set-window-option -g window-status-bell-style "fg=#${base01},bg=#${base08}"

      # scrolling with mouse
      set-option -g mouse on
    '';
  };
}
