-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require 'cmp'

cmp.setup({
	-- Enable LSP snippets
	snippet = {
		expand = function(args)
			require 'luasnip'.lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		-- Add tab support
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		})
	},

	-- Installed sources
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'omni' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = 'buffer' },
		{ name = 'treesitter' },
	},
})

cmp.setup.cmdline(':', {
	sources = {
		{ name = 'cmdline' }
	}
})

cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})
