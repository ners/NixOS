vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end

		local buffer = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		require("lsp-inlayhints").on_attach(client, buffer)
	end,
})
