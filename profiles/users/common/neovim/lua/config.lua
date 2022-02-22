-- Use space as leader key
vim.g.mapleader = ' '

-- Enable mouse support
vim.opt.mouse = 'a'

vim.opt.encoding = "utf-8"

-- Backspace works on every char in insert mode
vim.opt.backspace = "indent,eol,start"

-- Enable background buffer
vim.o.hidden = true

-- Show line numbers
vim.opt.number = true

-- Share the sign column with the number column to prevent text flicker
--vim.opt.signcolumn = 'number'
vim.opt.signcolumn = 'yes'

-- Display command in bottom bar
vim.opt.showcmd = true

-- Tabs are 4 spaces wide
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Use hard tabs, soft tabs can be enabled on filetype basis
vim.opt.expandtab = false

-- Autoindent
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show matching brackets
vim.o.showmatch  = true

-- Split direction
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
