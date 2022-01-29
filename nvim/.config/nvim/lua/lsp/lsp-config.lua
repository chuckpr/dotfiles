local nvim_lsp = require("lspconfig")

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover,
                                          {border = 'rounded'}),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers
                                                      .signature_help,
                                                  {border = 'rounded'})
}

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
                   opts)
    buf_set_keymap('n', '<leader>wa',
                   '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wr',
                   '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<leader>wl',
                   '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                   opts)
    buf_set_keymap('n', '<leader>D',
                   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',
                   opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>',
                   opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>q',
                   '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<leader>f',
                   '<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>', opts)

end

nvim_lsp.jedi_language_server.setup {on_attach = on_attach, handlers = handlers}

nvim_lsp.vimls.setup {on_attach = on_attach, handlers = handlers}

nvim_lsp.bashls.setup {on_attach = on_attach, handlers = handlers}

nvim_lsp.efm.setup {
    on_attach = on_attach,
    init_options = {documentFormatting = true},
    filetypes = {'python', 'lua', 'sh'},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            python = {
                {formatCommand = "black --quiet -", formatStdin = true},
                {
                    formatCommand = "isort --float-to-top --quiet -",
                    formatStdin = true
                }, {
                    lintCommand = 'flake8 --ignore E501 -',
                    lintStdin = true,
                    lintFormats = {'%f:%l:%c: %m'}
                }
            },
            lua = {{formatCommand = "lua-format -i", formatStdin = true}},
            sh = {
                {formatCommand = "shfmt -i 2 -ci -s -bn", formatStdin = true},
                {
                    lintCommand = 'shellcheck -f gcc -x',
                    lintSource = 'shellcheck'
                }
            }
        }
    },
    handlers = handlers
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false}
        }
    },
    handlers = handlers
}

nvim_lsp.dockerls.setup {on_attach = on_attach}

nvim_lsp.groovyls.setup {
    on_attach = on_attach,
    cmd = {"java", "-jar", os.getenv("GROOVY_LS_JARFILE")},
    handlers = handlers
}

require'lsp_signature'.setup {
    on_attach = on_attach,
    transparency = 100,
    toggle_key = '<C-x>',
    handlers = handlers
}

nvim_lsp.bashls.setup {on_attach = on_attach, handlers = handlers}
