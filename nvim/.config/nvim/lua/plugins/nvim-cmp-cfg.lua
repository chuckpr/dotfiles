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
            select = true
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
                cmp_tabnine = '[TabNine]'
            }
        })
    }

})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done',
             cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))
