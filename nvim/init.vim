packadd minpac
call minpac#init()

"linting"
call minpac#add('w0rp/ale') 
highlight ALEWarning ctermbg=240
let g:ale_linters = {'bash': ['shellcheck']}

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

set autoindent

au BufNewFile,BufRead *.py
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set fileformat=unix

au BufNewFile,BufRead *.js,*.json.*.yaml
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab
