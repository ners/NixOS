local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup({
	-- Enable LSP snippets
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(),
		['<Down>'] = cmp.mapping.select_next_item(),
        -- Manually trigger completion
		['<C-Space>'] = cmp.mapping.complete(),
        -- Enter to apply completion
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
        -- Tab support
        ['<Tab>'] = cmp.mapping(function (fallback)
            if luasnip.expandable() then
                luasnip.expand()
            elseif cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function (fallback)
            local copilot_keys = vim.fn["copilot#Accept"]()
            if copilot_keys ~= "" then
                vim.api.nvim_feedkeys(copilot_keys, "i", true)
            else
                fallback()
            end
        end, {'i', 's'}),
	},

    sources = {
		{ name = 'nvim_lsp' },
		{ name = 'omni' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = 'buffer' },
		{ name = 'treesitter' },
	},
})

-- cmp-cmdline
require'cmp'.setup.cmdline(':', {
    sources = {
        { name = 'cmdline' },
    },
    mapping = cmp.mapping.preset.cmdline({
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item()),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item()),
    })
})

require'cmp'.setup.cmdline('/', {
    sources = {
        { name = 'buffer' },
    },
    mapping = cmp.mapping.preset.cmdline({
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item()),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item()),
    })
})

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- require('lspconfig')['hls'].setup {
--   capabilities = capabilities
-- }
