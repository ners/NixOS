{ config, pkgs, lib, ... }:

let
  loadPlugin = plugin: ''
    set rtp^=${plugin}
    set rtp+=${plugin}/after
  '';
  plugins = with pkgs.vimPlugins; [
    # colorizer # Preview hex colours. Extremely slow performance on large files
    # completion-nvim # Completion engine similar to cmp
    # haskell-vim # Haskell highlighting?
    # neoscroll-nvim # Smooth scrolling
    # null-ls-nvim # Allow non-LSP sources to hook into LSP client
    # psc-ide-vim # Purescript
    # sonokai # Theme
    # vim-commentary # Language-agnostic comment toggling
    # vim-devicons # Add file type icons to file browser
    # vim-ormolu # Automatically run ormolu
    # vim-terraform # Terraform syntax highlighting
    # which-key-nvim
    # yats-vim # Typescript syntax highlighting

    barbar-nvim # Improved tabs
    cmp-buffer # Current buffer words
    cmp-cmdline # Commands
    cmp-nvim-lsp # LSP
    coc-eslint # CoC should be replaced by LSP - but tsserver still works better
    coc-nvim
    coc-prettier
    coc-tsserver
    conflict-marker-vim # Git merge conflicts utils and visualisation
    conjure # Clojure evaluation
    copilot-vim # Github Copilot integration
    edge # Theme
    fzf-checkout-vim # Manage Git branches with fzf
    # fzf-vim # integrate fzf
    # fzfWrapper # integrate fzf
    fzf-lua # fzf integration rewritten in lua
    impatient-nvim # Speed up startup time
    lexima-vim # Auto close brackets, tags, etc.
    lsp_signature-nvim # Open floating window with function signature when calling functions
    luasnip # Snippet engine used by cmp
    nvim-base16 # Theme
    nvim-bqf # Better quickfix window
    nvim-cmp # Completion engine
    nvim-code-action-menu # Better code action menu
    nvim-lspconfig # All sorts of language-specific LSP configs
    nvim-tree-lua # File browser
    nvim-treesitter # Enable AST-aware highlighting and actions
    nvim-treesitter-refactor # Enable renaming symbols (AST-aware)
    nvim-ts-rainbow # Coloured parentheses
    sort-nvim # Better sorting with :Sort
    vim-abolish # Preserve case when substituting
    vim-airline # New bottom status line
    vim-airline-themes # Themes for bottom status line
    # vim-easymotion # Jump anywhere on screen by searching for characters
    vim-fugitive # Git integration (staging, committing, reverting...)
    vim-gitgutter # Highlight unstaged Git changes
    vim-graphql # GraphQL syntax highlighting
    vim-nix # Nix syntax highlighting
    vim-projectionist # Jump between files with the same prefix
    vim-startify # Startup splash screen
    vim-surround # Add shortcuts to surround text with characters (parens, quotes...)
    vim-swap # Add shortcuts to swap delimited items (function args...)
  ];
in
{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Cousine" "RobotoMono" "FiraCode" ]; })
    clojure-lsp
    lua
    nodePackages.typescript-language-server
    nodejs
    python3
    rnix-lsp
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
