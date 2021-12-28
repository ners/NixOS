-- Reload file when it has changed
vim.opt.autoread = true

local au = require('au')
au({'VimEnter', 'FocusGained', 'BufEnter'}, {
	'*',
	function()
		vim.api.nvim_command('checktime')
	end
})
