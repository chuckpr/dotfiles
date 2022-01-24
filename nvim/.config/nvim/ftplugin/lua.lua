local cmd = vim.api.nvim_command
cmd('autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_seq_sync(nil, 1000)')
cmd('set expandtab')
cmd('set softtabstop')
cmd('set shiftwidth=4')
cmd('set tabstop=4')
