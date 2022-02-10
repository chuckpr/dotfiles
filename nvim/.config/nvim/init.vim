if &shell =~# 'fish$'
    set shell=sh
endif

source ~/.config/nvim/minpac.vim
source ~/.config/nvim/highlight.vim
source ~/.config/nvim/settings.vim
source ~/.config/nvim/mappings.vim
source ~/.config/nvim/autocommands.vim

luafile ~/.config/nvim/lua/lsp/lsp-config.lua
luafile ~/.config/nvim/lua/plugins/nvim-cmp-cfg.lua
luafile ~/.config/nvim/lua/plugins/nvim-autopairs.lua
luafile ~/.config/nvim/lua/plugins/nvim-treesitter-cfg.lua
luafile ~/.config/nvim/lua/chuckpr/gitsigns.lua
luafile ~/.config/nvim/lua/chuckpr/material-theme.lua
luafile ~/.config/nvim/lua/chuckpr/toggleterm.lua
luafile ~/.config/nvim/lua/chuckpr/lualine.lua
luafile ~/.config/nvim/lua/chuckpr/indent-blankline.lua
luafile ~/.config/nvim/lua/chuckpr/diagnostic.cfg.lua
luafile ~/.config/nvim/lua/chuckpr/nvim-tree.lua
luafile ~/.config/nvim/lua/chuckpr/which-key.lua
luafile ~/.config/nvim/lua/chuckpr/neoclip.lua
luafile ~/.config/nvim/lua/chuckpr/telescope.lua
luafile ~/.config/nvim/lua/chuckpr/luasnip.lua
