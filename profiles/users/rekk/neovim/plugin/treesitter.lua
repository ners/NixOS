require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indentation = {
        enable = true,
    },
    refactor = {
        highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
        },
        highlight_current_scope = { enable = true },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "R",
            },
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition_lsp_fallback = "gd",
                list_definitions = "gD",
                list_definitions_toc = "gO",
                goto_next_usage = "n",
                goto_previous_usage = "n",
            },
        },
    },
}
