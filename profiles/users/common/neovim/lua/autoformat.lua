-- Format the file before it is written
require'au'.BufWritePre = {
	'*',
	function()
		vim.lsp.buf.formatting_sync(nil, 1000)
	end
}
