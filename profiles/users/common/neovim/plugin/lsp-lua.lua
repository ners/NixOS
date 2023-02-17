require 'lspconfig'.lua_ls.setup {
	cmd = { 'lua-language-server' },
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' },
			}
		}
	}
}
