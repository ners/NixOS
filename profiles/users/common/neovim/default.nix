{ config, pkgs, lib, ... }:

let
  plugins = {
    stable = pkgs.vimPlugins;
    unstable = pkgs.unstable.vimPlugins;
    master = pkgs.master.vimPlugins;
    local = pkgs.local.vimPlugins;
  };
in
{
  home.packages = with pkgs; [
    neovim-qt
    nixpkgs-fmt
    rnix-lsp
    sumneko-lua-language-server
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with plugins.master; [
      (nvim-treesitter.withPlugins (_: pkgs.master.tree-sitter.allGrammars))
      bufferline-nvim
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-omni
      cmp-path
      cmp-treesitter
      cmp_luasnip
      crates-nvim
      fidget-nvim
      fzf-lsp-nvim
      fzf-vim
      fzfWrapper
      gitsigns-nvim
      impatient-nvim
      incsearch-vim
      indent-blankline-nvim
      litee-calltree-nvim
      litee-filetree-nvim
      litee-nvim
      litee-symboltree-nvim
      lsp_extensions-nvim
      lsp_signature-nvim
      lualine-nvim
      luasnip
      mkdir-nvim
      neoscroll-nvim
      neovim-ayu
      nvim-autopairs
      nvim-cmp
      nvim-dap
      nvim-dap-ui
      nvim-lspconfig
      nvim-tree-lua
      nvim-web-devicons
      plenary-nvim
      popup-nvim
      rust-tools-nvim
      tagbar
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-ui-select-nvim
      vimtex
      which-key-nvim
    ];
    extraConfig = builtins.readFile ./init.vim;
  };
  xdg.configFile = {
    "nvim/lua".source = ./lua;
    "nvim/plugin".source = ./plugin;
    "nvim/ftplugin".source = ./ftplugin;
    "nvim/ginit.vim".text = builtins.readFile ./ginit.vim;
  };
}
