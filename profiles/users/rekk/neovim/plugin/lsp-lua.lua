require'lspconfig'.sumneko_lua.setup{
	on_attach = require'on-attach',
	cmd = { 'lua-language-server' },
	settings = {
		Lua = {
			diagnostics = {
				globals = {'vim'},
			}
		}
	}
}
