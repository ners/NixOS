{ pkgs, lib, ... }:

{
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
}
