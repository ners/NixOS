local function on_attach(client, buffer)
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec([[
			augroup lsp_document_highlight
				autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]], false)
	end
end

return on_attach
