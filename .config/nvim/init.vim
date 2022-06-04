call plug#begin('~/.vim/plugged')

Plug 'hoob3rt/lualine.nvim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': 'TSUpdate' }
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'CraneStation/cranelift.vim'
Plug 'mfussenegger/nvim-dap'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

call plug#end()

set mouse=a
set number
set tabstop=4 softtabstop=0 expandtab shiftwidth=4
set clipboard=unnamedplus
set signcolumn=yes
set cursorline
set completeopt=menu,menuone,noselect

colorscheme onehalfdark
highlight Comment cterm=italic
highlight Pmenu ctermbg=8 ctermfg=15
highlight Normal ctermbg=233 ctermfg=15
highlight LineNr ctermbg=234 ctermfg=248
highlight CursorLineNr ctermbg=235 ctermfg=255
highlight SignColumn ctermbg=234 ctermfg=248
highlight MsgArea ctermbg=234 ctermfg=255

lua << EOF
require'lualine'.setup()
options = { theme = 'onedark' }

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
    }
}

-- LSP Stuff
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' },
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'rust-tools'.setup{}

-- require'lspconfig'.rust_analyzer.setup{ capabilities = capabilities }
require'lspconfig'.pyright.setup{ capabilities = capabilities }
require'lspconfig'.hls.setup{ capabilities = capabilities }
require'lspconfig'.ocamllsp.setup { capabilities = capabilities }
require'lspconfig'.gopls.setup{ capabilities = capabilities }
require'lspconfig'.clangd.setup{ capabilities = capabilities }
require'lspconfig'.cmake.setup{ capabilities = capabilities }
require'lspconfig'.tsserver.setup{ capabilities = capabilities }
require'lspconfig'.html.setup{ capabilities = capabilities }
require'lspconfig'.zls.setup{ capabilities = capabilities }

EOF

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

let g:rustfmt_autosave = 1
