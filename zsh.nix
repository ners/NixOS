{ config, pkgs, ... }:
{
	users.defaultUserShell = pkgs.zsh;

	programs.zsh = {
		enable = true;
		autosuggestions.enable = true;
		enableCompletion = true;
		syntaxHighlighting.enable = true;
	};
}
