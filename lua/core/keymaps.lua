-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local key = vim.keymap

-- Better indenting
key.set('v', '<', '<gv')
key.set('v', '>', '>gv')

-- Move selected text up and down
key.set('v', 'J', "<CMD>m '>+1<CR>gv=gv")
key.set('v', 'K', "<CMD>m '<-2<CR>gv=gv")

-- Buffers --
key.set('n', '<leader>n', '<CMD>bnext <CR>')
key.set('n', '<leader>p', '<CMD>bprevious <CR>')
key.set('n', '<leader>bd', '<CMD>bdelete <CR>')
key.set('n', '<leader>s', '<CMD>vsplit <CR>')

-- Editor --
key.set('n', '<leader>ca', vim.lsp.buf.code_action)
key.set('n', '<leader>cr', vim.lsp.buf.rename)
key.set('n', '<leader>gd', vim.lsp.buf.definition)
key.set('n', '<leader>gD', vim.lsp.buf.declaration)
key.set('n', '<leader>cf', vim.lsp.buf.format)
key.set('n', '<leader>sf', 'z=')

-- Searching --
key.set('n', '<Esc>', '<CMD>nohlsearch <CR>')

-- Copy to System Clipboard --
key.set('v', '<leader>cc', '"+y', { desc = 'Copy to system clipboard' })
