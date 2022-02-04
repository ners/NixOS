require'lspconfig'.clangd.setup{
	autostart = true,
	cmd = {
		'clangd',
		'--background-index',
		'--inlay-hints',
		'--clang-tidy',
		'--compile-commands-dir=build',
	},
}
