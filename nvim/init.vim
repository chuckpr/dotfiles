if &shell =~# 'fish$'
    set shell=sh
endif

packadd minpac
call minpac#init()

" Liquid
call minpac#add('tpope/vim-Liquid')

" nextflow vim
call minpac#add('LukeGoodsell/nextflow-vim')

" vim-sneak
call minpac#add('justinmk/vim-sneak')

" emmet
call minpac#add('mattn/emmet-vim')

" syntax plugin for TOML
call minpac#add('cespare/vim-toml')

" temporarily highlit yanked text
call minpac#add('machakann/vim-highlightedyank')
highlight HighlightedyankRegion ctermbg=125

" python function/class text object
call minpac#add('jeetsukumaran/vim-pythonsense')

" indent line
call minpac#add('Yggdroot/indentLine')
let g:indentLine_char = '⎸'
let g:indentLine_enabled = 1
let g:indentLine_color_term = 24

" vim-fish
call minpac#add('dag/vim-fish')

" fugitive
call minpac#add('tpope/vim-fugitive')
highlight DiffChange ctermbg=60
highlight DiffText ctermbg=53

" unimpaired
call minpac#add('tpope/vim-unimpaired')

" vinegar
call minpac#add('tpope/vim-vinegar')
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" HTML
call minpac#add('othree/html5.vim')

" Python indent
call minpac#add('Vimjas/vim-python-pep8-indent')

" Commentary
call minpac#add('tpope/vim-commentary')

" fzf
call minpac#add('junegunn/fzf')
nnoremap <C-p> :<C-u>FZF<CR>
call minpac#add('junegunn/fzf.vim')

"linting
call minpac#add('w0rp/ale')
let g:ale_enabled = 0 " Turn on when needed
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
highlight ALEWarning ctermbg=240
let g:ale_linters = {'bash': ['shellcheck'], 'python': ['flake8', 'pylint']}
let g:ale_python_pylint_options = '--errors-only'
let g:ale_fixers = {'python': ['autopep8'], 'yaml': ['prettier']}

" Folding for Python
call minpac#add('tmhedberg/SimpylFold')
let g:SimplyFold_docstring_preview = 1
let g:SimpylFold_fold_import = 0

" toggle fold with spacebar
nnoremap <space> za

" COC
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})

highlight Pmenu ctermbg=61 ctermfg=15 cterm=None
highlight PmenuSel ctermfg=16 ctermbg=84 cterm=bold
highlight Search ctermbg=153 ctermfg=black

" tpope
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')

" Status line
call minpac#add('liuchengxu/eleline.vim')
set laststatus=2

" Jinja2
call minpac#add('lepture/vim-jinja')

" EditorConfig
call minpac#add('editorconfig/editorconfig-vim')

" Jsonnet
call minpac#add('google/vim-jsonnet')

" Terraform
call minpac#add('hashivim/vim-terraform')
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1

" minpac updates itself
call minpac#add('ktakata/minpac', {'type': 'opt'})

command! PacUpdate call minpac#update()
command! PacClean call minpac#clean()

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
set number
highlight LineNr ctermfg=241
" highlight cursorline
set cursorline
" interactive
set inccommand=nosplit
" insearch
set incsearch

set cmdheight=2

" MAPPINGS
"
" source init.vim
nnoremap <leader>so :so $MYVIMRC<CR>zv

" edit init.vim
nnoremap <leader>ev :e $MYVIMRC<CR>

" toggle ALE
nnoremap <leader>at :ALEToggle<CR>

" Exit terminal mode
tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

" Delete buffer
nnoremap <leader>bd :bd<CR>

" quit
nnoremap qq :q<CR>

"" FILETYPE SETTINGS
""
au BufNewFile,BufRead *.liquid
    \ set tabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab

au BufNewFile,BufRead *.py
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set fileformat=unix

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

" This is to access ALE's docs
packloadall
silent! helptags ALL

" tab/space-tab to move up/down in completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" let CR trigger completion
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Highlight symbol under cursor on CursorHold
highlight CocHighlightText ctermbg=239
autocmd CursorHold * call CocActionAsync('highlight')

" Highlight text color for linting errors
highlight CocErrorSign ctermfg=220
highlight CocWarningSign ctermfg=220

" time to wait
set updatetime=250

" rename variable with <leader>rn
nmap <leader>rn <Plug>(coc-rename)

" keep the signcolumn visible
set signcolumn=yes

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" root patterns for python
autocmd FileType python let b:coc_root_patterns = ['.git', 'Pipfile']

" hide all float windows
nmap <silent> <leader>h <Plug>(coc-float-hide)

" show documentation 
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Create mappings for function text object, requires document symbols feature
" of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
