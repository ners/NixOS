-- Closes the tree when you open a file; default: 0
vim.g.nvim_tree_quit_on_open = 0

-- Show indent markers when folders are open; default: 0
vim.g.nvim_tree_indent_markers = 1

-- Enable file highlight for git attributes (can be used without the icons); default: 0
vim.g.nvim_tree_git_hl = 1

-- Enable folder and file icon highlight for opened files/directories.; default: 0
vim.g.nvim_tree_highlight_opened_files = 1

-- This is the default. See :help filename-modifiers for more options
vim.g.nvim_tree_root_folder_modifier = ':~'

-- Append a trailing slash to folder names; default: 0
vim.g.nvim_tree_add_trailing = 1

-- Compact folders that only contain a single folder into one node in the file tree; default: 0
vim.g.nvim_tree_group_empty = 1

-- Disable the window picker; default: 0
vim.g.nvim_tree_disable_window_picker = 1

-- Used for rendering the space between the icon and the filename.
-- Use with caution, it could break rendering if you set an empty string depending on your font.
-- default: one space
vim.g.nvim_tree_icon_padding = ' '

-- used as a separator between symlinks' source and target.
-- default: ' ➛ '
vim.g.nvim_tree_symlink_arrow = ' ➛ '

-- Change cwd of nvim-tree to that of new buffer's when opening nvim-tree; default: 0
vim.g.nvim_tree_respect_buf_cwd = 1

-- When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
-- default: 1
vim.g.nvim_tree_create_in_closed_folder = 0

-- Control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
-- default: 1000
vim.g.nvim_tree_refresh_wait = 500

vim.g.nvim_tree_show_icons = {
	git = 1,
	folders = 1,
	files = 1,
	folder_arrows = 1,
}
vim.g.nvim_tree_icons = {
	default = '',
	symlink = '',
	git = {
		unstaged = '✗',
		staged = '✓',
		unmerged = '',
		renamed = '➜',
		untracked = '★',
		deleted = '',
		ignored = '◌'
	},
	folder = {
		arrow_open = '',
		arrow_closed = '',
		default = '',
		open = '',
		empty = '',
		empty_open = '',
		symlink = '',
		symlink_open = '',
	},
}

local tree = require'nvim-tree'
tree.setup {
	disable_netrw       = true,
	hijack_netrw        = true,
	open_on_setup       = true,
	ignore_ft_on_setup  = {},
	auto_close          = true,
	open_on_tab         = true,
	hijack_cursor       = false,
	update_cwd          = false,
	update_to_buf_dir   = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = false,
		icons = {
			hint = '',
			info = '',
			warning = '',
			error = '',
		},
	},
	update_focused_file = {
		enable      = true,
		update_cwd  = true,
		ignore_list = {},
	},
	system_open = {
		cmd  = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 30,
		height = 30,
		hide_root_folder = false,
		side = 'left',
		auto_resize = false,
		mappings = {
			custom_only = false,
			list = {},
		},
		number = false,
		relativenumber = false,
		signcolumn = 'yes',
	},
	trash = {
		cmd = 'trash',
		require_confirm = true,
	}
}

local au = require'au'

-- Start NvimTree and put the cursor back in the other window
au.VimEnter = {
	'*',
	function()
		require'nvim-tree'.open()
		vim.api.nvim_command('wincmd p')
	end
}
