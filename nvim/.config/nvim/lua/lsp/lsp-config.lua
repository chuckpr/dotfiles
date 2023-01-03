local nvim_lsp = require("lspconfig")

require('mason').setup({
    ui = {
        border = 'rounded',
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then desc = 'LSP: ' .. desc end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references,
        '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols,
        '[D]ocument [S]ymbols')
    nmap('<leader>ws',
        require('telescope.builtin').lsp_dynamic_workspace_symbols,
        '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder,
        '[W]orkspace [A]dd Folder')
    nmap('<lead}er>wr', vim.lsp.buf.remove_workspace_folder,
        '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format',
        function(_) vim.lsp.buf.format() end, {
        desc = 'Format current buffer with LSP'
    })
end

local servers = {
    groovyls = {},
    dockerls = {},
    vimls = {},
    bashls = {},
    jedi_language_server = {}
}

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers) }

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name]
        }
    end
}

nvim_lsp.efm.setup {
    on_attach = on_attach,
    init_options = { documentFormatting = true },
    filetypes = { 'python', 'lua', 'sh' },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            python = {
                { formatCommand = "black --quiet -", formatStdin = true },
                {
                    formatCommand = "isort --float-to-top --quiet -",
                    formatStdin = true
                }, {
                    lintCommand = 'flake8 --ignore E501 -',
                    lintStdin = true,
                    lintFormats = { '%f:%l:%c: %m' }
                }
            },
            lua = { { formatCommand = "lua-format -i", formatStdin = true } },
            sh = {
                { formatCommand = "shfmt -i 2 -ci -s -bn", formatStdin = true },
                {
                    lintCommand = 'shellcheck -f gcc -x',
                    lintSource = 'shellcheck'
                }
            }
        }
    },
    handlers = capabilities
}

nvim_lsp.sumneko_lua.setup(require('config.lua-lsp'))

require 'lsp_signature'.setup()

-- Turn on lsp status information
require('fidget').setup()
