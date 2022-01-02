if &shell =~# 'fish$'
    set shell=sh
endif

packadd minpac
call minpac#init()

" gitsigns
call minpac#add('nvim-lua/plenary.nvim')
call minpac#add('lewis6991/gitsigns.nvim')
lua << EOF
require('gitsigns').setup {
    numhl = true,
    word_diff= true
}
EOF

" indent line for Neovim
call minpac#add('lukas-reineke/indent-blankline.nvim')
lua << EOF
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
EOF

" symbols outline
call minpac#add('simrat39/symbols-outline.nvim')

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

" autopairs
call minpac#add('windwp/nvim-autopairs')
lua require('nvim-autopairs').setup{}

" Python autoindent
" call minpac#add('Vimjas/vim-python-pep8-indent')

" nextflow vim
call minpac#add('LukeGoodsell/nextflow-vim')

" vim-fish
call minpac#add('dag/vim-fish')

" fzf
call minpac#add('junegunn/fzf')
nnoremap <C-p> :<C-u>FZF<CR>
call minpac#add('junegunn/fzf.vim')

" toggle fold with spacebar
nnoremap <space> za

" tpope
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')
" fugitive
call minpac#add('tpope/vim-fugitive')
highlight DiffChange ctermbg=60
highlight DiffText ctermbg=53
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

command! PacUpdate call minpac#update()
command! PacClean call minpac#clean()

luafile ~/.config/nvim/lua/lsp/lsp-config.lua
luafile ~/.config/nvim/lua/plugins/nvim-cmp-cfg.lua
luafile ~/.config/nvim/lua/plugins/nvim-autopairs.lua
luafile ~/.config/nvim/lua/plugins/nvim-treesitter-cfg.lua

" SETTINGS
"
set hidden
set autoindent
set wildmenu
set wildmode=list:longest,full
" line number, column number, virtual column number, and relative position in
" status line
set ruler
" no more backup files (files with ~ extension)
" no swapfile
set noswapfile
" display unprintible characters like $ at end of line
set list
" you can have unwritten changes in a file and open a new file
set hidden
" search highlighting off by default
set nohlsearch
" turn on modeline
set modeline
" turn on line numbers
set relativenumber
highlight LineNr ctermfg=241
" highlight cursorline
set cursorline
" interactive
set inccommand=nosplit
" insearch
set incsearch

set cmdheight=3

set updatetime=1000

" Highlight yanked text
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup EN


" MAPPINGS
"
" source init.vim
nnoremap <leader>so :so $MYVIMRC<CR>zv

" edit init.vim
nnoremap <leader>ev :e $MYVIMRC<CR>

" edit lsp config
nnoremap <leader>el :e ~/.config/nvim/lua/lsp/lsp-config.lua<CR>

" Exit terminal mode
tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

" Delete buffer
nnoremap <leader>bd :bd<CR>

" quit
nnoremap qq :q<CR>

" open a terminal in vsplit
set splitright
nnoremap <leader>term :vsplit<CR>:term fish<CR>

"" FILETYPE SETTINGS
""
au BufNewFile,BufRead *.liquid
    \ set tabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab

au BufNewFile,BufRead *.sh
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set fileformat=unix

au BufNewFile,BufRead Dockerfile*
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set fileformat=unix

au BufNewFile,BufRead *.js,*.json,*.yaml,*.yml,*.html,*.css,*.jsonnet
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |
    \ set conceallevel=0 |
    \ set smartindent

autocmd FileType fish compiler fish
autocmd FileType setlocal textwidth=79
autocmd FileType setlocal foldmethod=expr

augroup cursorholds
  autocmd!
  autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
augroup END

augroup highlights
  autocmd!
  highlight Pmenu ctermfg=254 ctermbg=19
  highlight PmenuSel ctermfg=235 ctermbg=194
  highlight LspReferenceText ctermbg=79 ctermfg=17
  highlight LspReferenceRead ctermbg=79 ctermfg=17
  highlight LspReferenceWrite ctermbg=79 ctermfg=17
  highlight NormalFloat ctermbg=54 ctermfg=224
  highlight GitSignsAddLn ctermfg=213
augroup END

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
