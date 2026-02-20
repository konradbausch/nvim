-------------------------------------------------------------------------------
-- SETTINGS & GLOBALS
-------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.cursorline = true 
opt.relativenumber = true
opt.mouse = 'a'
opt.ignorecase = true
opt.smartcase = true
opt.undofile = true
opt.signcolumn = 'yes'
opt.updatetime = 250
opt.scrolloff = 10
opt.undolevels = 10000

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
opt.fixendofline = true

-- Spell checking
opt.spell = true
opt.spelllang = 'en,de'
opt.spellsuggest = "best,5,timeout:200"

-- Undo tree
vim.g.undotree_SetFocusWhenToggle = 1

-------------------------------------------------------------------------------
-- PLUGIN MANAGEMENT (vim.pack)
-------------------------------------------------------------------------------
vim.pack.add{
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/Mofiqul/vscode.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/Saghen/blink.cmp',
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/scalameta/nvim-metals',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/mbbill/undotree',
  'https://github.com/seblj/roslyn.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
}

-------------------------------------------------------------------------------
-- PLUGIN CONFIGURATION
-------------------------------------------------------------------------------
vim.cmd.colorscheme "vscode"

require("ibl").setup()
require('oil').setup({
  columns = {},
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cs', 'python', 'scala', 'lua', 'vim', 'vimdoc' },
  callback = function() pcall(vim.treesitter.start) end,
})

local builtin = require('telescope.builtin')
pcall(require('telescope').load_extension, 'fzf')

-------------------------------------------------------------------------------
--- LSP and AUTOCOMPLETE
-------------------------------------------------------------------------------
vim.lsp.enable('pyright')

require('blink.cmp').setup({
  fuzzy = { implementation = "lua" },
  keymap = {
    preset = 'default',
    ['<CR>'] = { 'accept', 'fallback' },
    ['<C-space>'] = { 'accept', 'fallback' },
    ['<C-e>'] = { 'hide' },
    ['<C-n>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
  },
})

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
  on_attach = function(client)
    -- Disable LSP semantic tokens; treesitter handles highlighting without lag
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

require('mason').setup({
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
})

-- OmniSharp (disabled in favour of roslyn)
-- vim.lsp.config('omnisharp', {})
-- vim.lsp.enable('omnisharp')

vim.lsp.config("roslyn", {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

require('roslyn').setup({
  cmd = {
    vim.fn.stdpath("data") .. "/mason/bin/roslyn" .. (vim.fn.has("win32") == 1 and ".cmd" or ""),
  },
  -- Choose a specific solution to avoid loading all of them in a large repo.
  -- Uncomment and set the pattern to auto-select:
  -- choose_target = function(targets)
  --   return vim.iter(targets):find(function(t) return t:match("YourSolution.sln") end)
  -- end,
  lock_target = false,  -- use :Roslyn target to switch between solutions
  filewatching = "auto",
})

-- Scala
local metals = require("metals")
local metals_config = metals.bare_config()
metals_config.capabilities = require('blink.cmp').get_lsp_capabilities()

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
})

-------------------------------------------------------------------------------
-- KEYMAPS 
-------------------------------------------------------------------------------
local key = vim.keymap

-- Undo Tree
key.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle Undo Tree' })

-- Discovery / Keybinding Lists
key.set('n', '<leader>?', builtin.keymaps, { desc = 'Search all keybindings (Telescope)' })
key.set('n', '<leader>wk', function() require('which-key').show() end, { desc = 'List keybindings (Which-Key)' })

-- Better indenting
key.set('v', '<', '<gv', { desc = 'Indent left and keep selection' })
key.set('v', '>', '>gv', { desc = 'Indent right and keep selection' })

-- Move selected text
key.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
key.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Buffers
key.set('n', '<leader>n', '<CMD>bnext<CR>', { desc = 'Next buffer' })
key.set('n', '<leader>p', '<CMD>bprevious<CR>', { desc = 'Previous buffer' })
key.set('n', '<leader>bd', '<CMD>bdelete<CR>', { desc = 'Delete buffer' })
key.set('n', '<leader>s', '<CMD>vsplit<CR>', { desc = 'Split window vertically' })

-- Oil (File Explorer)
key.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory (Oil)" })

-- Telescope
key.set('n', '<leader>ff', function()
  builtin.git_files({ show_untracked = true })
end, { desc = 'Find files (respects .gitignore)' })
key.set('n', '<leader>fF', builtin.find_files, { desc = 'Find all files (ignores .gitignore)' })
key.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep (Search text)' })
key.set('n', '<leader>fb', builtin.buffers, { desc = 'List open buffers' })
key.set('n', '<leader>fh', builtin.help_tags, { desc = 'Search help documentation' })

-- LSP / Editor
key.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP: Code action' })
key.set('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'LSP: Rename symbol' })
key.set('n', '<leader>gd', vim.lsp.buf.definition, { desc = 'LSP: Go to definition' })
key.set('n', '<leader>gD', vim.lsp.buf.declaration, { desc = 'LSP: Go to declaration' })
key.set('n', '<leader>cf', vim.lsp.buf.format, { desc = 'LSP: Format document' })
key.set('n', '<leader>sf', 'z=', { desc = 'Suggest spelling correction' })

-- Searching
key.set('n', '<Esc>', '<CMD>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Clipboard
key.set('v', '<leader>cc', '"+y', { desc = 'Copy selection to system clipboard' })
