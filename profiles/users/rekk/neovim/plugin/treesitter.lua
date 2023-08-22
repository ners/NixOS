require'nvim-treesitter.configs'.setup {
    parser_install_dir = "$HOME/.config/nvim/treesitter",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    rainbow = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['af'] = "@function.outer",
                ['if'] = "@function.inner",
            },
        },
    },
    refactor = {
        highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
        },
    },
}
