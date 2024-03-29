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
nnoremap <leader>fc :Telescope neoclip<CR>

tnoremap <esc> <c-\><c-n> 

nnoremap <leader>gp :G push<CR>
nnoremap <leader>gg :G<CR>

nnoremap <space> za

" luasnip
nnoremap <leader>rls :source ~/.config/nvim/lua/chuckpr/luasnip.lua<CR>
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
