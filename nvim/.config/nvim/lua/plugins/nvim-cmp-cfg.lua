local cmp = require 'cmp'
local lspkind = require('lspkind')
local luasnip = require('luasnip')
lspkind.init()

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
        vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
            col)
        :match("%s") == nil
end

cmp.setup({

    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end
    },

    sources = {
        { name = 'nvim_lsp' }, { name = 'buffer' }, { name = 'luasnip' },
        { name = 'path' }, { name = 'cmp_tabnine' }
    },

    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping(cmp.mapping.abort(), { 'i', 's' }),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 's' }),
        ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 's' }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" })
    }),

    window = { documentation = { maxheight = 10 } },

    experimental = { ghost_text = true, native_menu = false },

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
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = 'buffer' } }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, {
        { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } }
    })
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
