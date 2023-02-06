{ config, pkgs, lib, ... }:

let
  loadPlugin = plugin: ''
    set rtp^=${plugin}
    set rtp+=${plugin}/after
  '';
  plugins = with pkgs.vimPlugins; [
      # which-key-nvim
      vim-abolish
      barbar-nvim
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      coc-eslint
      coc-nvim
      coc-prettier
      coc-tsserver
      # colorizer - extremely slow performance on large files
      completion-nvim
      conflict-marker-vim
      conjure
      edge
      fzf-checkout-vim
      fzf-vim
      fzfWrapper
      haskell-vim
      impatient-nvim
      lexima-vim
      lsp_signature-nvim
      luasnip
      neoscroll-nvim
      null-ls-nvim
      # nvim-base16
      sonokai
      nvim-bqf
      nvim-cmp
      nvim-code-action-menu
      nvim-lspconfig
      nvim-tree-lua
      nvim-treesitter
      nvim-treesitter-refactor
      nvim-ts-rainbow
      psc-ide-vim
      vim-airline
      vim-airline-themes
      vim-commentary
      vim-devicons
      vim-easymotion
      vim-fugitive
      vim-gitgutter
      vim-graphql
      vim-nix
      vim-ormolu
      vim-projectionist
      vim-startify
      vim-surround
      vim-swap
      vim-terraform
      yats-vim
    ];
in {
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Cousine" "RobotoMono" "FiraCode" ]; })
    clojure-lsp
    lua
    nixpkgs-fmt
    nodePackages.typescript-language-server
    nodejs
    python3
    rnix-lsp
    sumneko-lua-language-server
    yarn
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;

    withPython3 = true;
    extraPython3Packages = (ps: with ps; [
      pynvim
    ]);

    extraConfig = lib.mkForce ''
      " Workaround for broken handling of packpath by vim8/neovim for ftplugins -- see https://github.com/NixOS/nixpkgs/issues/39364#issuecomment-425536054 for more info
      filetype off | syn off
      ${builtins.concatStringsSep "\n" (map loadPlugin plugins)}
      filetype indent plugin on | syn on
      ${builtins.readFile ./init.vim}
    '';
  };

  xdg.configFile = {
    "nvim/lua".source = lib.mkForce ./lua;
    "nvim/plugin".source = lib.mkForce ./plugin;

    # TS/CoC config
    "nvim/coc-settings.json".text = builtins.toJSON {
      coc.preferences.formatOnSaveFiletypes = [ "typescript" "typescriptreact" ];
      coc.preferences.jumpCommand = "tabe";
      coc.preferences.snippets.enable = false;
      diagnostics.enable = false;
      eslint.packageManager = "yarn";
      eslint.probe = [ "typescript" "typescriptreact" ];
      eslint.run = "onType";
      eslint.workingDirectories = [{ mode = "auto"; }];
      signature.enable = false;
      typescript.autoClosingTags = true;
      typescript.format.enabled = true;
      typescript.format.insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true;
      typescript.preferences.importModuleSpecifier = "non-relative";
      typescript.preferences.quoteStyle = "double";
      typescript.suggest.autoImports = true;
      typescript.suggest.completeFunctionCalls = true;
      typescript.suggest.includeAutomaticOptionalChainCompletions = true;
      typescript.suggest.includeCompletionsForImportStatements = true;
    };
  };
}
