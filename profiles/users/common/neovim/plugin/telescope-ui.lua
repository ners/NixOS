local actions = require'telescope.actions'
local builtin = require'telescope.builtin'

require'telescope'.setup {
	defaults = {
		mappings = {
			n = {
				["<leader>ca"] = builtin.lsp_code_actions,
			}
		}
	}
}
--require'telescope'.load_extension'ui-select'
