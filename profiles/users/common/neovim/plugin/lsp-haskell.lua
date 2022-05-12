require'lspconfig'.hls.setup{
	on_attach = require'on-attach',
	settings = {
		haskell = {
			formattingProvider = 'fourmolu'
		},
	},
}
