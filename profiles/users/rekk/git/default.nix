{ ... }:

{
  programs.git = {
    enable = true;
    ignores = [ "*.swp" ".DS_STORE" ".projections.json" ".direnv" ];
    extraConfig = {
      init.defaultBranch = "master";
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      alias = {
        co = "checkout";
        ci = "commit";
        lg =
          "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative -n 10";
        nb = "checkout -b";
        st = "status";
        sw = "switch -";
      };

      difftastic.enable = true;
    };
  };
}
