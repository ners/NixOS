local keymapOpts = { noremap = true, silent = true }
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end
local function on_attach(client, buffer)
    require 'lsp_signature'.on_attach {
        hint_prefix = ''
    }
    vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', keymapOpts)
    vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', keymapOpts)
    vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', keymapOpts)
    -- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', keymapOpts)

    vim.api.nvim_buf_set_keymap(buffer, 'n', 'gd', '<cmd>lua require\'fzf-lua\'.lsp_definitions()<CR>', keymapOpts)
    vim.api.nvim_buf_set_keymap(buffer, 'n', 'gr', '<cmd>lua require\'fzf-lua\'.lsp_references()<CR>', keymapOpts)
    -- vim.api.nvim_buf_set_keymap(buffer, 'n', ',', '<cmd>lua require\'fzf-lua\'.lsp_code_actions()<CR>', keymapOpts)
    -- vim.api.nvim_buf_set_keymap(buffer, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', keymapOpts)
    -- vim.api.nvim_buf_set_keymap(buffer, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', keymapOpts)

    vim.api.nvim_buf_set_keymap(buffer, 'n', '`', '<cmd>lua vim.lsp.buf.hover()<CR>', keymapOpts)
    vim.api.nvim_buf_set_keymap(buffer, 'n', 'rr', '<cmd>lua vim.lsp.buf.rename()<CR>', keymapOpts)
    vim.api.nvim_buf_set_keymap(buffer, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format({async=true})<CR>', keymapOpts)
    -- --
    -- vim.api.nvim_buf_set_keymap(buffer, 'n', ',', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(buffer, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(buffer, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(buffer, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(buffer, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(buffer, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

    if client.server_capabilities.document_highlight then
        vim.api.nvim_exec([[
			augroup lsp_document_highlight
				autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]], false)
    end
end

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'double' }
)

sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '' })

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = ''
    }
})

return on_attach
