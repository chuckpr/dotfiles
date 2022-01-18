local cmd = vim.api.nvim_command
cmd('autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_seq_sync(nil, 1000)')
