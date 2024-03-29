local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>pi", builtin.git_files, { desc = "Telescope git files" })
vim.keymap.set("n", "<leader>pg", function()
    builtin.grep_string { search = vim.fn.input("Grep > ") }
end, { desc = "Telescope grep search" })
vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>pt", builtin.treesitter, { desc = "Telescope treesitter symbol search" })
vim.keymap.set("n", "<leader>ps", builtin.lsp_workspace_symbols, { desc = "Telescope symbol search (LSP)" })
vim.keymap.set("n", "<leader>pr", builtin.lsp_references, { desc = "Telescope variable references (LSP)" })
vim.keymap.set("n", "<leader>pd", builtin.diagnostics, { desc = "Telescope diagnostics (LSP)" })
