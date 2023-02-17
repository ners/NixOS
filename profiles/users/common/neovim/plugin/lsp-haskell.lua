require 'lspconfig'.hls.setup {
	filetypes = { 'haskell', 'lhaskell', 'cabal' },
	settings = {
		haskell = {
			cabalFormattingProvider = "cabalfmt",
			formattingProvider = 'fourmolu'
		},
	},
}
