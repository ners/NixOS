{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		vimPlugins.ack-vim
		vimPlugins.base16-vim
		vimPlugins.coc-clangd
		vimPlugins.coc-cmake
		vimPlugins.coc-git
		vimPlugins.coc-json
		vimPlugins.coc-nvim
		vimPlugins.direnv-vim
		vimPlugins.haskell-vim
		vimPlugins.nerdtree
		vimPlugins.nerdtree
		vimPlugins.sved
		vimPlugins.vim-devicons
		vimPlugins.vim-nerdtree-syntax-highlight
		vimPlugins.vim-nix
		vimPlugins.vim-pug
		vimPlugins.yats-vim
		neovim
		neovim-qt
	];

	environment.variables = {
		EDITOR = "nvim";
		VISUAL = "nvim-qt";
	};
}
