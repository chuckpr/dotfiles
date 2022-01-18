local cmd = vim.api.nvim_command
cmd('autocmd BufWritePre *.sh lua vim.lsp.buf.formatting_seq_sync(nil, 1000)')
