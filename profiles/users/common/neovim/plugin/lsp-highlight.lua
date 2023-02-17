vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspAttach_highlight", {}),
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end

		local buffer = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client.server_capabilities.documentHighlightProvider then
			local group = vim.api.nvim_create_augroup('CursorHighlight', {})
			-- Highlight occurrences under the cursor
			vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
				group = group,
				callback = vim.lsp.buf.document_highlight,
				buffer = buffer,
			})
			-- Clear occurrences when the cursor moves
			vim.api.nvim_create_autocmd('CursorMoved', {
				group = group,
				callback = vim.lsp.buf.clear_references,
				buffer = buffer,
			})
		end
	end,
})
