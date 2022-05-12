-- Format the file before it is written
local group = vim.api.nvim_create_augroup('AutoformatOnWrite', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
	group = group,
	callback = function() vim.lsp.buf.formatting_sync(nil, 1000) end
})
