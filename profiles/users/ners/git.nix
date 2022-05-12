{ pkgs, ... }:

let
  git = pkgs.git.override { withLibsecret = true; };
  git-credential-libsecret = git + "/bin/git-credential-libsecret";
in
{
  programs.git = {
    enable = true;
    package = git;
    delta.enable = true;
    userName = "ners";
    userEmail = "ners@gmx.ch";
    ignores = [ ".*" "!.envrc" "!.gitignore" "!.gitkeep" ];
    aliases = {
      commend = "commit --amend --no-edit";
      grog = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
      please = "push --force-with-lease";
      root = "rev-parse --show-toplevel";
    };
    extraConfig = {
      core.sshCommand = "ssh -F $HOME/.ssh/config";
      init.defaultBranch = "master";
      delta.navigate = true;
      merge.conflictStyle = "diff3";
      diff.colorMoved = "default";
      pull.rebase = true;
      push.default = "current";
      credential.helper = git-credential-libsecret;
      "filter \"lfs\"" = {
        required = true;
        clean = "git-lfs clean -- %f";
        process = "git-lfs filter-process";
        smudge = "git-lfs smudge -- %f";
      };
    };
  };

  # GitHub CLI
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.gh.enable
  # Aliases config imported in flake.
  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };
}
