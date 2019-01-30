packadd minpac
call minpac#init()

"linting
call minpac#add('w0rp/ale') 
highlight ALEWarning ctermbg=240
let g:ale_linters = {'bash': ['shellcheck']}
let g:ale_fixers = {'python': ['autopep8'], 'yaml': ['prettier']}

" Folding for Python  
call minpac#add('tmhedberg/SimpylFold')
let g:SimplyFold_docstring_preview = 1
let g:SimpylFold_fold_import = 0

" toggle fold with spacebar
nnoremap <space> za

" autocomplete with ncm2
call minpac#add('ncm2/ncm2')
call minpac#add('roxma/nvim-yarp')

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

highlight Pmenu ctermbg=73 ctermfg=white
highlight PmenuSel ctermbg=24 ctermfg=white

" current buffer
call minpac#add('ncm2/ncm2-bufword')

" path completion
call minpac#add('ncm2/ncm2-path')

" Jedi
call minpac#add('ncm2/ncm2-jedi')

" tpope
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')

" complete pairs (quotes, brackets, parentheses, etc.)
call minpac#add('jiangmiao/auto-pairs')

" minpac updates itself
call minpac#add('ktakata/minpac', {'type': 'opt'})

command! PacUpdate call minpac#update()
command! PacClean call minpac#clean()


" SETTINGS
"
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
" search highlighting on by default
set hlsearch


" MAPPINGS
"
" source init.vim
nnoremap <leader>so :so $MYVIMRC<CR>zv
" edit init.vim
nnoremap <leader>ev :e $MYVIMRC<CR>

" FILETYPE SETTINGS
"
au BufNewFile,BufRead *.py
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set fileformat=unix

au BufNewFile,BufRead *.js,*.json,*.yaml,*.yml
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab
