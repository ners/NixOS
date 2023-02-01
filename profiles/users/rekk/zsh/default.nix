{ config, pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = lib.mkForce {
      format = let
        items = [
          "username"
          "hostname"
          "directory"
          "git_branch"
          "git_commit"
          "git_state"
          "git_metrics"
          "git_status"
          "env_var"
          "custom"
          "sudo"
          "cmd_duration"
          "line_break"
          "jobs"
          "battery"
          "time"
          "status"
          "shell"
          "character"
        ];
      in lib.strings.concatMapStrings (item: "$" + item) items;
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    enableCompletion = true;

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreSpace = true;
    };

    sessionVariables = {
      BAT_THEME = "OneHalfDark";
    };

    # plugins = [
    #   {
    #     name = "just-zsh";
    #     file = "completions/just.zsh";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "casey";
    #       repo = "just";
    #       rev = "1.11.0";
    #       sha256 = "01cfs17i5jqq660dib2gg15dqwa2xgy5dz94pw14bb55p1i3d32d";
    #     };
    #   }
    # ];

    initExtra = (let
      scripts = [
        "source ${pkgs.fzf}/share/fzf/completion.zsh"
        "source ${pkgs.fzf}/share/fzf/key-bindings.zsh"
        "source ${pkgs.nix-zsh-completions}/share/zsh/plugins/nix/nix-zsh-completions.plugin.zsh"
        "source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        "source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh"
        "source ${pkgs.zsh-fzf-tab}/share/fzf-tab/lib/zsh-ls-colors/ls-colors.zsh"
        "source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
        # "source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        "source ${pkgs.zsh-z}/share/zsh-z/zsh-z.plugin.zsh"
      ];
    in (builtins.concatStringsSep "\n" scripts) + "\n"
    + builtins.readFile ./init.sh);
  };
}
