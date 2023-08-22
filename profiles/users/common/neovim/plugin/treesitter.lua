require'nvim-treesitter.configs'.setup{
    -- Syntax highlighting
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
    -- Coloured parens (unmaintained)
    rainbow = {
        enable = true,
    },
    -- Better indentation
	indent = {
		enable = true,
	},
    -- Better matching (% keybinding)
    matchup = {
        enable = true,
    },
    -- Automatically open/close tags
    autotag = {
        enable = true,
    },
    -- Smarter selection of objects
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
        },
    },
}
