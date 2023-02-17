vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspAttach_signature", {}),
	callback = function(args)
		require 'lsp_signature'.on_attach({}, args.buf)
	end,
})
