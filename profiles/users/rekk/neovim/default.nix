{ config, pkgs, lib, ... }:

let
  loadPlugin = plugin: ''
    set rtp^=${plugin}
    set rtp+=${plugin}/after
  '';
  plugins = with pkgs.vimPlugins; [

    # coc-eslint # CoC should be replaced by LSP - but tsserver still works better
    # coc-nvim
    # coc-prettier
    # coc-tsserver
    # colorizer # Preview hex colours. Extremely slow performance on large files
    # completion-nvim # Completion engine similar to cmp
    # fzf-vim # integrate fzf
    # fzfWrapper # integrate fzf
    # haskell-vim # Haskell highlighting?
    # neoscroll-nvim # Smooth scrolling
    # psc-ide-vim # Purescript
    # sonokai # Theme
    # sort-nvim # Better sorting with :Sort
    # vim-commentary # Language-agnostic comment toggling
    # vim-devicons # Add file type icons to file browser
    # vim-easymotion # Jump anywhere on screen by searching for characters
    # vim-graphql # GraphQL syntax highlighting
    # vim-ormolu # Automatically run ormolu
    # vim-terraform # Terraform syntax highlighting
    # vim-nix # Nix syntax highlighting
    # which-key-nvim
    # yats-vim # Typescript syntax highlighting
    # nvim-ts-rainbow # Coloured parentheses

    lsp_lines-nvim # Fully display diagnostics
    barbar-nvim # Improved tabs
    nvim-web-devicons # Icons for barbar
    cmp-buffer # Current buffer words
    cmp-cmdline # Commands
    cmp-nvim-lsp # LSP
    conflict-marker-vim # Git merge conflicts utils and visualisation
    conjure # Clojure evaluation
    copilot-vim # Github Copilot integration
    edge # Theme
    fzf-checkout-vim # Manage Git branches with fzf
    fzf-lua # fzf integration rewritten in lua
    lexima-vim # Auto close brackets, tags, etc.
    lsp_signature-nvim # Open floating window with function signature when calling functions
    luasnip # Snippet engine used by cmp
    null-ls-nvim # Allow non-LSP sources to hook into LSP client (e.g. formatters)
    nvim-base16 # Theme
    nvim-bqf # Better quickfix window
    nvim-cmp # Completion engine
    nvim-code-action-menu # Better code action menu
    nvim-lspconfig # All sorts of language-specific LSP configs
    nvim-tree-lua # File browser
    nvim-treesitter.withAllGrammars # Enable AST-aware highlighting and actions
    nvim-treesitter-refactor # Enable renaming symbols (AST-aware)
    typescript-nvim # Additional LSP features for TS (`import all`...)
    plenary-nvim # Additional Lua utils
    vim-abolish # Preserve case when substituting
    vim-airline # New bottom status line
    vim-airline-themes # Themes for bottom status line
    vim-fugitive # Git integration (staging, committing, reverting...)
    vim-gitgutter # Highlight unstaged Git changes
    vim-projectionist # Jump between files with the same prefix
    vim-startify # Startup splash screen
    vim-surround # Add shortcuts to surround text with characters (parens, quotes...)
    vim-swap # Add shortcuts to swap delimited items (function args...)

  ];
in
{
  home.packages = with pkgs; [
    # nodejs
    # yarn
    (nerdfonts.override { fonts = [ "Cousine" "RobotoMono" "FiraCode" ]; })
    clojure-lsp
    lua
    nixfmt
    nodePackages.typescript-language-server
    python3
    rnix-lsp
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
