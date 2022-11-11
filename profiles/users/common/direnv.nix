{ pkgs, lib, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    stdlib = ''
      # Quiet output
      export DIRENV_LOG_FORMAT=
      # Show errors
      strict_env
    '';
  };
}
