-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local home = os.getenv'HOME'
require'rust-tools'.setup{
  tools = { -- rust-tools options
	-- automatically set inlay hints (type hints)
	autoSetHints = true,
	hover_with_actions = true,
	runnables = {
		use_telescope = true,
	},
	inlay_hints = {
	  show_parameter_hints = true,
	  parameter_hints_prefix = "",
	  other_hints_prefix = "",
	},
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
	-- on_attach is a callback called when the language server attachs to the buffer
	-- on_attach = on_attach,
	settings = {
	  -- to enable rust-analyzer settings visit:
	  -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
	  ["rust-analyzer"] = {
		-- enable clippy on save
		checkOnSave = {
		  overrideCommand = 'clippy-driver'
		},
	  }
	}
  },
}
