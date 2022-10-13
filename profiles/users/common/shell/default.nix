{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ exa fd fzf zsh-completions ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = builtins.concatStringsSep "" [
        "$username"
        "$hostname"
        "$shlvl"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];
      directory.style = "blue";
      character = {
        success_symbol = "[»](purple)";
        error_symbol = "[»](red)";
        vicmd_symbol = "[«](green)";
      };
      git_branch = {
        format = "[$branch]($style)";
        style = "bright-black";
      };
      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        style = "cyan";
      };
      git_state = {
        #format = ''\([$state( $progress_current/$progress_total)]($style)\) '';
        style = "bright-black";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
    };
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      source "${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
      source "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
      source "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
      source "${pkgs.nix-zsh-completions}/share/zsh/plugins/nix/nix-zsh-completions.plugin.zsh"
      source "${pkgs.fzf}/share/fzf/completion.zsh"
      source "${pkgs.fzf}/share/fzf/key-bindings.zsh"
      source "${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
      source "${pkgs.zsh-fzf-tab}/share/fzf-tab/lib/zsh-ls-colors/ls-colors.zsh"
      ${builtins.readFile ./init.sh}
    '';

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
