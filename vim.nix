{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		vimPlugins.base16-vim
		vimPlugins.coc-git
		vimPlugins.coc-nvim
		vimPlugins.direnv-vim
		vimPlugins.haskell-vim
		vimPlugins.nerdtree
		vimPlugins.sved
		vimPlugins.vim-devicons
		vimPlugins.vim-nix
		vimPlugins.vim-pug
		unstable.vimPlugins.vim-nerdtree-syntax-highlight
		neovim
		neovim-qt
	];

	environment.variables = {
		EDITOR = "nvim";
		VISUAL = "nvim-qt";
	};
}
