{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ exa fd fzf zsh-completions ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      character = {
        success_symbol = "[»](bold green)";
        error_symbol = "[»](bold red)";
        vicmd_symbol = "[«](bold green)";
      };
    };
  };

  programs.zsh = {
    enable = true;
    initExtra = (let
      scripts = [
        "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
        "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix/nix-zsh-completions.plugin.zsh"
        "${pkgs.fzf}/share/fzf/completion.zsh"
        "${pkgs.fzf}/share/fzf/key-bindings.zsh"
        "${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
        "${pkgs.zsh-fzf-tab}/share/fzf-tab/lib/zsh-ls-colors/ls-colors.zsh"
      ];
      sources = map (script: ''source "${script}"'') scripts;
      imports = builtins.concatStringsSep "\n" sources;
      init = builtins.readFile ./init.sh;
    in imports + "\n" + init);

    shellAliases = {
      open = ''open() { xdg-open "$@" & disown }; open'';
      exa = "exa --tree --icons";
      gvim = "nvim-qt";
      make = "make -j$(nproc)";
      makevars =
        "make -pn | grep -A1 '^# makefile' | grep -v '^#\\|^--' | sort | uniq";
      scp = "scp -F $HOME/.ssh/config";
      ssh = "ssh -F $HOME/.ssh/config";
      sshfs = "sshfs -F $HOME/.ssh/config";
      ls = "ls --color=auto";
    };
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      # COLOUR (base16)

      # default statusbar colors
      set-option -g status-style "fg=#b8b8b8,bg=#282828"

      # default window title colors
      set-window-option -g window-status-style "fg=#b8b8b8,bg=default"

      # active window title colors
      set-window-option -g window-status-current-style "fg=#f7ca88,bg=default"

      # pane border
      set-option -g pane-border-style "fg=#282828"
      set-option -g pane-active-border-style "fg=#383838"

      # message text
      set-option -g message-style "fg=#d8d8d8,bg=#282828"

      # pane number display
      set-option -g display-panes-active-colour "#a1b56c"
      set-option -g display-panes-colour "#f7ca88"

      # clock
      set-window-option -g clock-mode-colour "#a1b56c"

      # copy mode highligh
      set-window-option -g mode-style "fg=#b8b8b8,bg=#383838"

      # bell
      set-window-option -g window-status-bell-style "fg=#282828,bg=#ab4642"
    '';
  };
}
