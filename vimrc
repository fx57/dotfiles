execute pathogen#infect()

source $VIMRUNTIME/evim.vim

let mapleader=','
nmap n nzz
nmap N Nzz
syntax enable
colo gc
" virtual edit everywhere
set ve=all
" Home row escape - mnemonic: leave insert mode
"imap <c-l> <esc>
" Move around splits with <c-hjkl>
"nnoremap <c-h> <c-w>h
"nnoremap <c-j> <c-w>j
"nnoremap <c-k> <c-w>k
"nnoremap <c-l> <c-w>l

set nowrap
if has("gui_running")
	au GUIEnter * simalt ~x
else
	set lines=55
	set columns=160
endif
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guioptions-=m
set guifont=Consolas:h13
set number
set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175,a:blinkon0
hi Cursor guifg=white guibg=red

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
