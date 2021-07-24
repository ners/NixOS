{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ exa fd fzf ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

      bindkey "$terminfo[kcuu1]" history-substring-search-up
      bindkey "$terminfo[kcud1]" history-substring-search-down

      source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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
      gvim = "nvim-qt";
      make = "make -j$(nproc)";
      makevars =
        "make -pn | grep -A1 '^# makefile' | grep -v '^#\\|^--' | sort | uniq";
      scp = "scp -F $HOME/.ssh/config";
      ssh = "ssh -F $HOME/.ssh/config";
      sshfs = "sshfs -F $HOME/.ssh/config";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim-qt";
    CABAL_CONFIG = "$HOME/.config/cabal/config";
    FZF_ALT_C_COMMAND = "fd -t d . /home";
    FZF_CTRL_T_COMMAND = "fd . /home";
    FZF_DEFAULT_COMMAND = "fd . /home";
    GIT_SSH_COMMAND = "ssh -F \\$HOME/.ssh/config";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
