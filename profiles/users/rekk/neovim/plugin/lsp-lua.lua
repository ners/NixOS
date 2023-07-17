require'lspconfig'.lua_ls.setup{
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
