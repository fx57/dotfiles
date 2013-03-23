execute pathogen#infect()

let mapleader=','
nmap n nzz
nmap N Nzz
syntax enable
colo gc
" virtual edit everywhere
set ve=all
" Home row escape - mnemonic: leave insert mode
imap <c-l> <esc>
" Move around splits with <c-hjkl>
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

set nowrap
set lines=55
set columns=160
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guioptions-=m
set guifont=Lucida\ Console:h9
set nu
 
map <leader>f :NERDTreeToggle<CR>

function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()

set tabstop=4
set shiftwidth=4
