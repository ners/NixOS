require 'nvim-tree'.setup {
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	renderer = {
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " → ",
			show = {
				file = true,
				folder = true,
				folder_arrow = false,
				git = true,
			},
		},
	},
	filesystem_watchers = {
		enable = true,
	},
}

-- Open nvim-tree when Vim starts
local function open_nvim_tree(data)
	-- buffer is a real file on the disk
	local real_file = vim.fn.filereadable(data.file) == 1

	-- buffer is a [No Name]
	local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

	if not real_file and not no_name then
		return
	end

	-- open the tree, find the file but don't focus it
	require("nvim-tree.api").tree.toggle({ focus = true, find_file = true, })
end

vim.api.nvim_create_autocmd('VimEnter', {
	group = vim.api.nvim_create_augroup('OpenNvimTreeOnStart', {}),
	callback = open_nvim_tree,
})

-- Automatically close the tab/vim when nvim-tree is the last window in the tab
vim.api.nvim_create_autocmd('BufEnter', {
	group = vim.api.nvim_create_augroup('CloseNvimTreeWhenLast', {}),
	command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
	nested = true,
})
