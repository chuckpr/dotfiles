local cmd = vim.api.nvim_command
cmd('autocmd BufWritePre *.sh lua vim.lsp.buf.format(nil, 1000)')
