require'nvim-tree'.setup {
	open_on_setup = true,
	open_on_setup_file = true,
	open_on_tab = true,
	update_focused_file = {
		enable = true,
	},
}

-- Automatically close the tab/vim when nvim-tree is the last window in the tab
vim.api.nvim_exec([[
	autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]], false)
