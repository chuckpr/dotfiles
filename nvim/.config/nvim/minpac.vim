packadd minpac
call minpac#init()

" lualine
call minpac#add('nvim-lualine/lualine.nvim')

" tabnine source
call minpac#add('tzachar/cmp-tabnine', {'do': '!./install.sh'})

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
lua << EOF
require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = true,
}
EOF

" symbols outline
" call minpac#add('simrat39/symbols-outline.nvim')

" LSP
call minpac#add('neovim/nvim-lspconfig')
call minpac#add('hrsh7th/nvim-cmp')
call minpac#add('hrsh7th/cmp-buffer')
call minpac#add('hrsh7th/cmp-nvim-lsp')
call minpac#add('hrsh7th/cmp-buffer')
call minpac#add('hrsh7th/cmp-path')
call minpac#add('ray-x/lsp_signature.nvim')

" snippets
call minpac#add('hrsh7th/vim-vsnip')
call minpac#add('hrsh7th/vim-vsnip-integ')
imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
smap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'

" treesitter
call minpac#add('nvim-treesitter/nvim-treesitter')
call minpac#add('nvim-treesitter/playground')
call minpac#add('nvim-treesitter/nvim-treesitter-textobjects')

" autopairs
call minpac#add('windwp/nvim-autopairs')
lua << EOF
require('nvim-autopairs').setup{
	ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", "")
}
EOF

" Python autoindent
" call minpac#add('Vimjas/vim-python-pep8-indent')

" nextflow vim
call minpac#add('LukeGoodsell/nextflow-vim')

" vim-fish
call minpac#add('dag/vim-fish')

" fzf
" call minpac#add('junegunn/fzf')
" nnoremap <C-p> :<C-u>FZF<CR>
" call minpac#add('junegunn/fzf.vim')

" tpope
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')
" fugitive
call minpac#add('tpope/vim-fugitive')
" unimpaired
call minpac#add('tpope/vim-unimpaired')
" vinegar
call minpac#add('tpope/vim-vinegar')
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
