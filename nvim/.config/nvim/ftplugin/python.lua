local cmd = vim.api.nvim_command
cmd('autocmd BufWritePre *.py lua vim.lsp.buf.format(nil, 1000)')

