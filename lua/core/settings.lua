-- Basic editor settings
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.mouse = 'a'          -- Enable mouse control
vim.opt.ignorecase = true    -- Ignore case in search
vim.opt.smartcase = true     -- But don't ignore it when search includes uppercase
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.scrolloff = 10

-- Indentation settings
vim.opt.expandtab = true     -- Convert tabs to spaces
vim.opt.shiftwidth = 2       -- Number of spaces for auto-indent
vim.opt.tabstop = 2          -- Number of spaces a tab counts for
vim.opt.smartindent = true   -- Auto-indent new lines
vim.opt.fixendofline = true  -- Insert final new line

-- Spell checking --
vim.opt.spell = true
vim.opt.spelllang = 'en,de'
vim.opt.spellsuggest = "best,5,timeout:200"

-- hide dot files by default, change with gh --
vim.g.netrw_list_hide = '\\(^\\|\\s\\s\\)\\zs\\.\\S\\+'
vim.g.netrw_winsize = 25       -- 25 percent window width
vim.g.netrw_banner = 0         -- Remove the banner at the top
vim.g.netrw_liststyle = 3      -- Tree style listing
