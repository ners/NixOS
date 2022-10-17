-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration

require 'rust-tools'.setup {
	tools = {
		autoSetHints = true,
		-- DEPRECATED: hover_with_actions = true,
		runnables = {
			use_telescope = true,
		},
		debuggables = {
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
		capabilities = require 'cmp_nvim_lsp'.default_capabilities(),
		on_attach = require 'on-attach',
		settings = {
			-- to enable rust-analyzer settings visit:
			-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
			["rust-analyzer"] = {
				assist = {
					importEnforceGranularity = true,
					importPrefix = "by_crate",
				},
				cargo = {
					allFeatures = true,
					runBuildScripts = true,
				},
				checkOnSave = {
					-- default: `cargo check`
					command = "clippy"
				},
				inlayHints = {
					lifetimeElisionHints = {
						enable = true,
						useParameterNames = true
					},
				},
				procMacro = {
					enable = true
				}
			}
		}
	}
}
