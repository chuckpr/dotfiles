" Highlight yanked text
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup EN

" highlight text under cursor
augroup cursorholds
  autocmd!
  autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
augroup END

" Turn off diagnostic when typing
augroup Diagnostic
  autocmd!
  au InsertEnter * :lua vim.diagnostic.disable()
  au InsertLeave * :lua vim.diagnostic.enable()
augroup END

augroup Nginx
  autocmd BufRead,BufNewFile *.conf setfiletype conf
augroup END
