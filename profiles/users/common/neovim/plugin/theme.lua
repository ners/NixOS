require 'lualine'.setup {
	options = {
		theme = 'base16',
		icons_enabled = true,
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {},
		always_divide_middle = true,
	}
}

vim.opt.guifont = { "Iosevka Nerd Font", "Emoji", ":h12" }

-- Show invisible characters
vim.opt.list = true
vim.opt.listchars = { tab = '› ', trail = '~', extends = '»', precedes = '«', nbsp = '_', }

local signs = {
	{ name = 'DiagnosticSignError', text = '🔥' },
	{ name = 'DiagnosticSignWarn',  text = '⚠️' },
	{ name = 'DiagnosticSignHint',  text = '💡' },
	{ name = 'DiagnosticSignInfo',  text = '🔸' },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

vim.diagnostic.config {
	-- show signs
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = 'minimal',
		border = 'rounded',
		source = 'always',
		header = '',
		prefix = '',
	},
}

--vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--	border = "rounded",
--})
--
--vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--	border = "rounded",
--})
