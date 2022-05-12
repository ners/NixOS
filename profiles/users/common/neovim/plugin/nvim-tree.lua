vim.g.nvim_tree_show_icons = {
	git = 1,
	folders = 1,
	files = 1,
	folder_arrows = 0,
}

require'nvim-tree'.setup {
	open_on_setup = true,
	open_on_setup_file = true,
	open_on_tab = true,
	update_focused_file = {
		enable = true,
	},
}

-- Automatically close the tab/vim when nvim-tree is the last window in the tab
vim.api.nvim_create_autocmd('BufEnter', {
	group = vim.api.nvim_create_augroup('CloseNvimTreeWhenLast', {}),
	command = "++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
})
