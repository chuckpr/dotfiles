local o = vim.o
local cmd = vim.api.nvim_command

-- number of spaces a Tab stands for
o.softtabstop = 4
o.expandtab = true
o.shiftwidth = 2
-- number of spaces that a Tab counts for
o.tabstop = 4
o.textwidth = 79
o.fileformat = "unix"

cmd('autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 1000)')
