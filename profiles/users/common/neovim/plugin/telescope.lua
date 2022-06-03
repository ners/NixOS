local actions = require 'telescope.actions'
local builtin = require 'telescope.builtin'

local telescope = require 'telescope'

telescope.setup {
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown {
			},
		},
	},
	defaults = {
		mappings = {
			n = {
				["<leader>ca"] = builtin.lsp_code_actions,
			}
		}
	}
}

telescope.load_extension 'fzf'
telescope.load_extension 'ui-select'
