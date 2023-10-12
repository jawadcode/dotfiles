vim.keymap.set("n", "<leader>tn", vim.cmd.tabnew, { desc = "new tab" })
vim.keymap.set("n", "<leader>te", vim.cmd.tabnext, { desc = "next tab" })
vim.keymap.set("n", "<leader>tp", vim.cmd.tabprevious, { desc = "previous tab" })

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "open netrw" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selection up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selection down" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "format buffer (LSP)" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "replace all occurrences of the current word" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "make file executable" })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd.so()
end)
