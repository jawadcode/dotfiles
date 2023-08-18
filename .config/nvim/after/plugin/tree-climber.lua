local key_opts = function(desc)
    return { noremap = true, silent = true, desc = desc }
end

local tc = require "tree-climber"
vim.keymap.set({ 'n', 'v', 'o' }, 'gp', tc.goto_parent, key_opts "goto parent node")
vim.keymap.set({ 'n', 'v', 'o' }, 'gc', tc.goto_child, key_opts "goto child node")
vim.keymap.set({ 'n', 'v', 'o' }, '[gs', tc.goto_next, key_opts "goto next sibling node")
vim.keymap.set({ 'n', 'v', 'o' }, ']gs', tc.goto_prev, key_opts "goto prev sibling node")
vim.keymap.set({ 'v', 'o' }, 'in', tc.select_node, key_opts "select node")
vim.keymap.set('n', '<C-k>', tc.swap_prev, key_opts "swap with prev node")
vim.keymap.set('n', '<C-j>', tc.swap_next, key_opts "swap with next node")
vim.keymap.set('n', '<C-h>', tc.highlight_node, key_opts "highlight node")
