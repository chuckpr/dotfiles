local cmp = require 'cmp'
local lspkind = require('lspkind')
lspkind.init()

cmp.setup({

    snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},

    sources = {
        {name = 'nvim_lsp'}, {name = 'path'}, {name = 'buffer'},
        {name = 'cmp_tabnine'}
    },

    mapping = {
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping(cmp.mapping.abort(), {'i', 's'}),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 's'}),
        ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 's'})
    },

    documentation = {maxheight = 10},

    experimental = {ghost_text = true, native_menu = false},

    formatting = {
        format = lspkind.cmp_format({
            with_text = true, -- do not show text alongside icons
            menu = {
                buffer = '[buffer]',
                nvim_lsp = '[LSP]',
                path = '[path]',
                cmp_tabnine = '[TabNine]',
                cmdline = '[cmd]'
            }
        })
    }

})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- search
cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- command  mode
cmp.setup.cmdline(':', {
    sources = {
        {name = 'path', keyword_length = 2},
        {name = 'cmdline', keyword_length = 2}
    }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
