{ config, pkgs, ... }:
let
	unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
	unstableOverride = import ( unstableTarball ) { config = config.nixpkgs.config; };
in
{
	nixpkgs.config.packageOverrides = pkgs: {
		unstable = unstableOverride;
	};

	environment.systemPackages = with pkgs; [
		vimPlugins.base16-vim
		vimPlugins.coc-git
		vimPlugins.coc-nvim
		vimPlugins.haskell-vim
		vimPlugins.nerdtree
		vimPlugins.sved
		vimPlugins.vim-devicons
		vimPlugins.vim-nix
		unstable.vimPlugins.vim-nerdtree-syntax-highlight
		neovim
		neovim-qt
	];

	environment.variables = {
		EDITOR = "nvim";
		VISUAL = "nvim-qt";
	};
}
