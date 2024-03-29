packadd minpac
call minpac#init()

" neoclip
call minpac#add('AckslD/nvim-neoclip.lua')

" which-key
call minpac#add('folke/which-key.nvim')

" nvim-tree
call minpac#add('kyazdani42/nvim-tree.lua')

" tmuux session picker
call minpac#add('camgraff/telescope-tmux.nvim')

" neoscroll
call minpac#add('karb94/neoscroll.nvim')
lua require('neoscroll').setup()

" Better python indent
call minpac#add('Vimjas/vim-python-pep8-indent')

" lualine
call minpac#add('nvim-lualine/lualine.nvim')

" toggleterm
call minpac#add('akinsho/toggleterm.nvim')

" lspkind
call minpac#add('onsails/lspkind-nvim')

" Telescoper 
call minpac#add('nvim-lua/plenary.nvim')
call minpac#add('nvim-telescope/telescope.nvim')

" material theme
call minpac#add('marko-cerovac/material.nvim')

" gitsigns
call minpac#add('lewis6991/gitsigns.nvim')

" indent line for Neovim
call minpac#add('lukas-reineke/indent-blankline.nvim')

" snippets
call minpac#add('L3MON4D3/LuaSnip')
call minpac#add('saadparwaiz1/cmp_luasnip')

" treesitter
call minpac#add('nvim-treesitter/nvim-treesitter')
call minpac#add('nvim-treesitter/playground')
call minpac#add('nvim-treesitter/nvim-treesitter-textobjects')

" autopairs
call minpac#add('windwp/nvim-autopairs')

" nextflow vim
call minpac#add('LukeGoodsell/nextflow-vim')

" vim-fish
call minpac#add('dag/vim-fish')

" tpope
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')
" fugitive
call minpac#add('tpope/vim-fugitive')
" Commentary
call minpac#add('tpope/vim-commentary')

" EditorConfig
call minpac#add('editorconfig/editorconfig-vim')

" minpac updates itself
call minpac#add('ktakata/minpac', {'type': 'opt'})

" Vim Script
call minpac#add('kyazdani42/nvim-web-devicons')
call minpac#add('folke/trouble.nvim')

lua << EOF
  require("trouble").setup {
  }
EOF

command! PacUpdate call minpac#update()
command! PacClean call minpac#clean()
