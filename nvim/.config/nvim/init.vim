if &shell =~# 'fish$'
    set shell=sh
endif

source ~/.config/nvim/minpac.vim

luafile ~/.config/nvim/lua/lsp/lsp-config.lua
luafile ~/.config/nvim/lua/plugins/nvim-cmp-cfg.lua
luafile ~/.config/nvim/lua/plugins/nvim-autopairs.lua
luafile ~/.config/nvim/lua/plugins/nvim-treesitter-cfg.lua
luafile ~/.config/nvim/lua/chuckpr/gitsigns.lua
luafile ~/.config/nvim/lua/chuckpr/material-theme.lua
luafile ~/.config/nvim/lua/chuckpr/toggleterm.lua
luafile ~/.config/nvim/lua/chuckpr/lualine.lua
luafile ~/.config/nvim/lua/chuckpr/indent-blankline.lua

source ~/.config/nvim/mappings.vim
source ~/.config/nvim/autocommands.vim
source ~/.config/nvim/settings.vim
source ~/.config/nvim/highlight.vim

lua << EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- This will disable virtual text, like doing:
    -- let g:diagnostic_enable_virtual_text = 0
    virtual_text = false,

    -- This is similar to:
    -- let g:diagnostic_show_sign = 1
    -- To configure sign display,
    --  see: ":help vim.lsp.diagnostic.set_signs()"
    signs = true,

    -- This is similar to:
    -- "let g:diagnostic_insert_delay = 1"
    update_in_insert = true,
  }
)
EOF

lua << EOF
local signs = { Error = " ", Warn = " ", Hint = " ", Info =  " "}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
EOF
