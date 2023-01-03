if &shell =~# 'fish$'
    set shell=sh
endif

source ~/.config/nvim/minpac.vim
luafile ~/.config/nvim/packer.lua

lua << EOF
-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})
EOF

luafile ~/.config/nvim/lua/chuckpr/material-theme.lua
luafile ~/.config/nvim/lua/lsp/lsp-config.lua
luafile ~/.config/nvim/lua/plugins/nvim-cmp-cfg.lua
luafile ~/.config/nvim/lua/plugins/nvim-autopairs.lua
luafile ~/.config/nvim/lua/plugins/nvim-treesitter-cfg.lua
luafile ~/.config/nvim/lua/chuckpr/gitsigns.lua
luafile ~/.config/nvim/lua/chuckpr/toggleterm.lua
luafile ~/.config/nvim/lua/chuckpr/lualine.lua
luafile ~/.config/nvim/lua/chuckpr/indent-blankline.lua
luafile ~/.config/nvim/lua/chuckpr/diagnostic.cfg.lua
luafile ~/.config/nvim/lua/chuckpr/which-key.lua
luafile ~/.config/nvim/lua/chuckpr/neoclip.lua
luafile ~/.config/nvim/lua/chuckpr/telescope.lua
luafile ~/.config/nvim/lua/chuckpr/luasnip.lua

source ~/.config/nvim/highlight.vim
source ~/.config/nvim/mappings.vim
source ~/.config/nvim/autocommands.vim
source ~/.config/nvim/settings.vim
