{ config, pkgs, ... }:
{
	users.defaultUserShell = pkgs.zsh;
	programs.zsh = {
		enable = true;
		autosuggestions.enable = true;
		enableCompletion = true;
		syntaxHighlighting.enable = true;
		interactiveShellInit = ''
			source ${pkgs.grml-zsh-config}/etc/zsh/zshrc
			eval "$(starship init zsh)"
			eval "$(direnv hook zsh)"
		'';
		shellAliases = {
			vim = "nvim";
			gvim = "nvim-qt";
			make = "make -j$(nproc)";
            makevars = "make -pn | grep -A1 '^# makefile' | grep -v '^#\\|^--' | sort | uniq";
		};
		promptInit = "";
	};
}
