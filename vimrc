execute pathogen#infect()

source $VIMRUNTIME/evim.vim
imap <F10> <C-O>:

let mapleader=','
nmap n nzz
nmap N Nzz
syntax enable
colo gc
" virtual edit everywhere
set virtualedit=all
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

	" support alt key in 7-bit terminals like mintty
	let c='a'
	while c <= 'z'
	  exec "set <A-".c.">=\e".c
	  exec "imap \e".c." <A-".c.">"
	  let c = nr2char(1+char2nr(c))
	endw
	let c='A'
	while c <= 'Z'
	  exec "set <A-".c.">=\e".c
	  exec "imap \e".c." <A-".c.">"
	  let c = nr2char(1+char2nr(c))
	endw
	set notimeout
endif

" hide gui crap
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guioptions-=m

set guifont=Consolas:h13
set number
set guicursor=n-v-c:block-Cursor/lCursor,ve:hor13-Cursor,o:hor50-Cursor,i-ci:hor13-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
hi Cursor guifg=white guibg=red

" Always the display the current line and column
set ruler

" Always have a status line
set laststatus=2

" Allow backspace over everything
set backspace=indent,start

" Wrap to the line above the current one when using arrow keys, backpsace
" and space character
set whichwrap=b,s,<,>,[,]

inoremap <silent> <A-f> <C-O>:NERDTreeToggle<CR>

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

"-----------------------------------------------------------------------
" Brief bindings

" Keep the cursor in the same column for some of the cursor movement commands
set nostartofline

" Disable menu accelerators.  The Alt key that activates the menu interfere
" with the Brief key mappings.
set winaltkeys=no

"-----------------------
" Cursor movement
"-----------------------

" Make cursor keys ignore wrapping
inoremap <silent> <Down> <C-O>gj
inoremap <silent> <Up> <C-O>gk

" goto beginning of previous word
inoremap <silent> <C-Left> <C-O>B

" goto beginning of next word
inoremap <silent> <C-Right> <C-O>W

" brief-home-key
inoremap <silent> <Home> <C-O>:call <SID>BriefHomeKey()<CR>

" brief-end-key
inoremap <silent> <End> <C-O>:call <SID>BriefEndKey()<CR>

"-----------------------
" Editing
"-----------------------

" Toggle insert mode
inoremap <silent> <A-i> <Ins>

" Delete the current line
inoremap <silent> <A-d> <C-O>dd

" Copy line or mark to scrap buffer.  Vim register 'a' is used as the scrap
" buffer
inoremap <silent> <kPlus> <C-O>"ayy
vnoremap <silent> <kPlus> "ay

" Cut line or mark to scrap buffer.  Vim register 'a' is used as the scrap
" buffer
inoremap <silent> <kMinus> <C-O>"add
vnoremap <silent> <kMinus> "ax

" Paste scrap buffer contents to current cursor position.  Vim register 'a' is
" used as the scrap buffer
inoremap <silent> <Ins> <C-O>"aP

" undo last operation
inoremap <silent> <kMultiply> <C-O>u
inoremap <A-u> <C-O>u
inoremap <A-U> <C-O><C-R>

" linewise selections
inoremap <silent> <S-Down> <C-O>gH<S-Down>
inoremap <silent> <S-Up> <C-O>gH<S-Up>

"-----------------------
" Buffer
"-----------------------

" open file
inoremap <A-e> <C-O>:edit 

" exit
inoremap <silent> <A-x> <C-O>:confirm quit<CR>

" read file
inoremap <A-r> <C-O>:read  

" Save the current file
inoremap <silent> <A-w> <C-O>:call <SID>BriefSave()<CR>

" Save the current file in a different file name
inoremap <silent> <A-o> <C-O>:call <SID>BriefSaveAs()<CR>

" Select next buffer from the buffer list
inoremap <silent> <A-n> <C-O>:bnext<CR>

" Select previous buffer from the buffer list
inoremap <silent> <A--> <C-O>:bprevious<CR>
inoremap <silent> <A-p> <C-O>:bprevious<CR>

" Delete current buffer from buffer list
inoremap <silent> <C--> <C-O>:bdelete<CR>
inoremap <silent> <C-kMinus> <C-O>:bdelete<CR>

" Display buffer list
inoremap <A-b> <C-O>:buffers<CR>:buffer 

" Display buffer information
"inoremap <A-f> <C-O>:file<CR>

"-----------------------
" Windows
"-----------------------

" goto the window below the current window
inoremap <silent> <a-down> <c-o><c-w>w

" goto the window above the current window
inoremap <silent> <a-up> <c-o><c-w>w

function! s:BriefHomeKey()
   " if we are on the first char of the line, go to the top of the screen
   if (col(".") <= 1)
      " if on top of screen, go to top of file
      let l:a = line(".")
      normal H0
      if (line(".") == l:a)
         " we did not move! so ...
         normal 1G
      endif
   else
      " goto beginning of line
      normal 0
   endif
endfunction

" This function is taken from vim online web page and modified
function! s:BriefEndKey()
    let cur_col = virtcol(".")
    let line_len = virtcol("$")

    if cur_col != line_len
        " The cursor is not at the end of the line, goto the end of the line
        execute "normal " . line_len . "|"
    else
        " The cursor is already at the end of the line
        let cur_line = line(".")
        normal L         " goto the end of the current page
        if line(".") == cur_line
            " Cursor is already at the end of the page
            normal G  " Goto the end of the file
            let line_len = virtcol("$")
            if line_len > 0
                execute "normal " . line_len . "|"
            endif
        else
            " Cursor was not already in the end of the page
            let line_len = virtcol("$")
            if line_len > 0
                execute "normal " . line_len . "|"
            endif
        endif
    endif
endfunction

function! s:BriefSave()
    if expand("%") == ""
        if has("gui_running")
            browse write
        else
            let fname = input("Save file as: ")
            if fname == ""
                return
            endif
            execute "write " . fname
        endif
    else
        write!
    endif
endfunction

function! s:BriefSaveAs()
    if has("gui_running")
        browse saveas
    else
        let fname = input("Save file as: ")
        if fname == ""
            return
        endif
        execute "saveas " . fname
    endif
endfunction

set tabstop=4
set shiftwidth=4

