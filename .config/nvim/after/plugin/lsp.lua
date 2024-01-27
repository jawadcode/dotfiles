local lsp = require "lsp-zero".preset {}

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end

    vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>ho", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>df", function() vim.diagnostic.open_float { border = "rounded" } end, opts)
    vim.keymap.set("n", "<leader>gn", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leader>gp", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

lsp.on_attach(on_attach)

lsp.setup_servers { "bashls", "clangd", "cssls", "hls", "html", "jdtls", "leanls", "ocamllsp", "pyright", "swift_mesonls", "texlab", "tsserver" }

require "lspconfig".lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require "cmp"
local cmp_select = { behaviour = cmp.SelectBehavior.Select }
cmp.setup {
    mapping = {
        ["<M-k>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<M-j>"] = cmp.mapping.select_next_item(cmp_select),
        ["<tab>"] = cmp.mapping.confirm { select = true },
        ["<S-tab>"] = nil,
    }
}

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    }
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    })
})

vim.g.rustaceanvim = {
    server = {
        on_attach = on_attach,
        capabilities = lsp.get_capabilities()
    }
}

require "idris2".setup {
    server = { on_attach = on_attach }
}

local lean = require "lean"

lean.setup {
    lsp = {
        on_attach = on_attach,
    },
    infoview = {
        autoopen = true,
        width = 50,
        height = 20,
        horizontal_position = "bottom",
        separate_tab = false,
        indicators = "auto",
    },
    progress_bars = {
        enable = true,
        character = "│",
        priority = 10,
    },
    mappings = true,
}
