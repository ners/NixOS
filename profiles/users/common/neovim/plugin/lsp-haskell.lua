require 'lspconfig'.hls.setup {
	--filetypes = { 'haskell', 'lhaskell', 'cabal' },
	settings = {
		haskell = {
			--cabalFormattingProvider = "cabal-fmt",
			formattingProvider = 'fourmolu'
		},
	},
}
