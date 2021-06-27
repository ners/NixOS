{ config, pkgs, ... }:
{
	users.defaultUserShell = pkgs.zsh;

	programs.zsh = {
		enable = true;
		autosuggestions.enable = true;
		enableCompletion = true;
		syntaxHighlighting.enable = true;
		interactiveShellInit = ''
			bindkey "$terminfo[kcuu1]" history-substring-search-up
			bindkey "$terminfo[kcud1]" history-substring-search-down
			source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
			eval "$(${pkgs.starship}/bin/starship init zsh)"
			eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
		'';
		shellAliases = {
			open = "xdg-open";
			vim = "nvim";
			gvim = "nvim-qt";
			make = "make -j$(nproc)";
			makevars = "make -pn | grep -A1 '^# makefile' | grep -v '^#\\|^--' | sort | uniq";
			scp = "scp -F $HOME/.ssh/config";
			ssh = "ssh -F $HOME/.ssh/config";
			sshfs = "sshfs -F $HOME/.ssh/config";
		};
		promptInit = "";
	};

	environment.systemPackages = with pkgs; [
		direnv
		nix-direnv
	];

	environment.pathsToLink = [ "/share/nix-direnv" ];
}
