require("neo-tree").setup({
	close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
	filtered_items = {
		hide_dotfiles = false,
	},
})

vim.api.nvim_create_autocmd("UiEnter", {
	desc = "Open Neotree automatically",
	group = vim.api.nvim_create_augroup("neotree", {}),
	callback = function()
		vim.cmd "Neotree show"
	end,
})

vim.cmd [[
highlight NeoTreeGitConflict gui=NONE
highlight NeoTreeGitUntracked gui=NONE
highlight NeoTreeRootName gui=NONE
]]
