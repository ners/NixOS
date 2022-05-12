{ config, pkgs, lib, ... }:

let
  plugins = {
    stable = pkgs.vimPlugins;
    unstable = pkgs.unstable.vimPlugins;
    master = pkgs.master.vimPlugins;
    local = pkgs.local.vimPlugins;
  };
  concatFiles = lib.concatFilesInDir "\n";
in
{
  home.packages = with pkgs; [
    neovim-qt
    nixfmt
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
      cmp-vsnip
      crates-nvim
      fidget-nvim
      fzf-lsp-nvim
      fzf-vim
      fzfWrapper
      gitsigns-nvim
      impatient-nvim
      incsearch-vim
      litee-calltree-nvim
      litee-filetree-nvim
      litee-nvim
      litee-symboltree-nvim
      lsp_extensions-nvim
      lualine-nvim
      mkdir-nvim
      neoscroll-nvim
      nvim-autopairs
      nvim-cmp
      nvim-dap
      nvim-dap-ui
      nvim-lspconfig
      nvim-tree-lua
      nvim-web-devicons
      onedark-nvim
      plenary-nvim
      popup-nvim
      rust-tools-nvim
      tagbar
      telescope-nvim
      vim-vsnip
      vimtex
      which-key-nvim
    ];
    extraConfig = concatFiles ./vim;
  };
  xdg.configFile = {
    "nvim/lua".source = ./lua;
    "nvim/plugin".source = ./plugin;
    "nvim/ftplugin".source = ./ftplugin;
    "nvim/ginit.vim".text = concatFiles ./gvim;
  };
}
