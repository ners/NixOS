require'lspconfig'.clangd.setup{
	on_attach = require'on-attach',
	cmd = {
		'clangd',
		'--background-index',
		'--inlay-hints',
		'--clang-tidy',
		'--compile-commands-dir=build',
	},
}
