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
    initExtra = ''
      fpath+=($HOME/.nix-profile/share/zsh/site-functions)
      # Reload the zsh-completions
      autoload -U compinit && compinit

      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

      export LESS_TERMCAP_mb=$'\E[01;31m'
      export LESS_TERMCAP_md=$'\E[01;38;5;74m'
      export LESS_TERMCAP_me=$'\E[0m'
      export LESS_TERMCAP_se=$'\E[0m'
      export LESS_TERMCAP_so=$'\E[38;5;246m'
      export LESS_TERMCAP_ue=$'\E[0m'
      export LESS_TERMCAP_us=$'\E[04;38;5;146m'

      # Functional Home-/End-/Delete-/Insert-keys
      bindkey '\e[1~'   beginning-of-line  # Linux console
      bindkey '\e[H'    beginning-of-line  # xterm
      bindkey '\e[2~'   overwrite-mode     # Linux console, xterm, gnome-terminal
      bindkey '\e[3~'   delete-char        # Linux console, xterm, gnome-terminal
      bindkey '\e[4~'   end-of-line        # Linux console
      bindkey '\e[F'    end-of-line        # xterm
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word


      source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      bindkey "^[[A" history-substring-search-up
      bindkey "^[[B" history-substring-search-down

      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.nix-zsh-completions}/share/zsh/plugins/nix/nix-zsh-completions.plugin.zsh

      source ${pkgs.fzf}/share/fzf/completion.zsh
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/lib/zsh-ls-colors/ls-colors.zsh

      # set list-colors to enable filename colorizing
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

      # preview directory's content with exa when completing cd
      zstyle ':fzf-tab:complete:*:*' fzf-preview 'exa -1 --color=always $realpath'
      # switch group using `,` and `.`
      zstyle ':fzf-tab:*' switch-group ',' '.'
      # give a preview of commandline arguments when completing `kill`
      zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
      zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
        '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
      zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
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
}
