{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		neovim
		neovim-qt
	];

	environment.variables = {
		EDITOR = "nvim";
		VISUAL = "nvim-qt";
	};
}
