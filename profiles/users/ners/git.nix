{ ... }:

{
  programs.git = {
    enable = true;
    userName = "ners";
    userEmail = "ners@gmx.ch";
    ignores = [ ".*" "!.envrc" "!.gitignore" ];
    aliases = {
      please = "push --force-with-lease";
      commend = "commit --amend --no-edit";
      grog = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
    };
    extraConfig = {
      core = {
        init.defaultBranch = "master";
        sshCommand = "ssh -F $HOME/.ssh/config";
      };
      pull.rebase = true;
      push.default = "current";
      credential.helper = "libsecret";
      "filter \"lfs\"" = {
        required = true;
        clean = "git-lfs clean -- %f";
        process = "git-lfs filter-process";
        smudge = "git-lfs smudge -- %f";
      };
    };
  };
}
