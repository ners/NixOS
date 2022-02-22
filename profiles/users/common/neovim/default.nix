{ config, pkgs, ... }:

with builtins;

let
  filesInDir = dir: attrNames (readDir dir);
  unlines = concatStringsSep "\n";
in
{
  home.packages = with pkgs; [
    nixfmt
    rnix-lsp
    sumneko-lua-language-server
    unstable.neovim-qt
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.unstable.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with pkgs.master; with vimPlugins; [
      (nvim-treesitter.withPlugins (_: tree-sitter.allGrammars))
      bufferline-nvim
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-omni
      cmp-path
      cmp-treesitter
      cmp-vsnip
      delimitMate
      fidget-nvim
      fzf-lsp-nvim
      fzf-vim
      fzfWrapper
      gitsigns-nvim
      incsearch-vim
      litee-calltree-nvim
      litee-filetree-nvim
      litee-nvim
      litee-symboltree-nvim
      lsp_extensions-nvim
      lualine-nvim
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
    extraConfig = (
      let
        vimFiles = filesInDir ./vim;
        vimParts = map (name: readFile "${./vim}/${name}") vimFiles;
        luaFiles = filesInDir ./lua;
        luaReqs =
          map (file: ":lua require('${pkgs.lib.removeSuffix ".lua" file}')")
            luaFiles;
      in
      unlines (vimParts ++ luaReqs)
    );
  };
  xdg.configFile = {
    "nvim/lua".source = ./lua;
    "nvim/ftplugin".source = ./ftplugin;
    "nvim/ginit.vim".text = (
      let
        vimFiles = filesInDir ./gvim;
        vimParts = map (name: readFile "${./gvim}/${name}") vimFiles;
      in
      unlines vimParts
    );
  };
}
