{ config, pkgs, lib, ... }:

let
  vimPlugins = {
    stable = pkgs.vimPlugins;
    unstable = pkgs.unstable.vimPlugins;
    master = pkgs.master.vimPlugins;
    local = pkgs.local.vimPlugins;
  };
  loadPlugin = plugin: ''
    set rtp^=${plugin}
    set rtp+=${plugin}/after
  '';
  loadPlugins = lib.pipef [ (builtins.map loadPlugin) lib.unlines ];
  plugins = with vimPlugins.unstable; [
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
    nvim-autopairs
    nvim-base16
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
in
{
  home.packages = with pkgs; [
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
    extraConfig = with config.colorScheme.colors; ''
      " Workaround for broken handling of packpath by vim8/neovim for ftplugins -- see https://github.com/NixOS/nixpkgs/issues/39364#issuecomment-425536054 for more info
      filetype off | syn off
      ${loadPlugins plugins}
      filetype indent plugin on | syn on
      ${builtins.readFile ./init.vim}
      lua << EOF
      require('base16-colorscheme').setup({
          base00 = '#${base00}', base01 = '#${base01}', base02 = '#${base02}', base03 = '#${base03}',
          base04 = '#${base04}', base05 = '#${base05}', base06 = '#${base06}', base07 = '#${base07}',
          base08 = '#${base08}', base09 = '#${base09}', base0A = '#${base0A}', base0B = '#${base0B}',
          base0C = '#${base0C}', base0D = '#${base0D}', base0E = '#${base0E}', base0F = '#${base0F}',
      })
      EOF
    '';
  };
  xdg.configFile = {
    "nvim/lua".source = ./lua;
    "nvim/plugin".source = ./plugin;
    "nvim/ftplugin".source = ./ftplugin;
    "nvim/ginit.vim".source = ./ginit.vim;
  };
}
