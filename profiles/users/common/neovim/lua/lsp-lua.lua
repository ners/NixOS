require'lspconfig'.sumneko_lua.setup{
	cmd = { 'lua-language-server' },
	settings = {
		Lua = {
			diagnostics = {
				globals = {'vim'},
			}
		}
	}
}
