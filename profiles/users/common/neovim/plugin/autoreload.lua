-- Reload file when it has changed
vim.opt.autoread = true

local group = vim.api.nvim_create_augroup('ReloadFileOnChange', { clear = true })

vim.api.nvim_create_autocmd({ 'VimEnter', 'FocusGained', 'BufEnter' }, {
	group = group,
	command = 'checktime',
})
