" source init.vim
nnoremap <leader>so :so $MYVIMRC<CR>zv

" edit init.vim
nnoremap <leader>ev :e $MYVIMRC<CR>

" edit lsp config
nnoremap <leader>el :e ~/.config/nvim/lua/lsp/lsp-config.lua<CR>

" switch martial theme
nnoremap <leader>th :lua require("material.functions").toggle_style()<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fr :lua require'telescope.builtin'.git_files{}<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>
nnoremap <leader>fs :Telescope tmux sessions<CR>

" vsnip mappings
inoremap <expr> <C-j> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
snoremap <expr> <C-j> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'

tnoremap <esc> <c-\><c-n> 
