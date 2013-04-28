execute pathogen#infect()

"--- evim
"source $VIMRUNTIME/evim.vim
" Don't use Vi-compatible mode.
set nocompatible

" Use the mswin.vim script for most mappings
"--mswin start

" set the 'cpoptions' to its Vim default
if 1	" only do this when compiled with expression evaluation
  let s:save_cpo = &cpoptions
endif
set cpo&vim

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin

" backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-X is Cut
vnoremap <C-X> "+x

" CTRL-C is Copy
vnoremap <C-C> "+y

" CTRL-V is Paste
map <C-V>		"+gP
cmap <C-V>		<C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>		<C-V>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u
inoremap <C-Z> <C-O>u

" CTRL-Y is Redo (although not repeat); not in cmdline though
"noremap <C-Y> <C-R>
"inoremap <C-Y> <C-O><C-R>

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" restore 'cpoptions'
set cpo&
if 1
  let &cpoptions = s:save_cpo
  unlet s:save_cpo
endif
"--mswin end

" Vim is in Insert mode by default
set insertmode

" Make a buffer hidden when editing another one
set hidden

" Make cursor keys ignore wrapping
inoremap <silent> <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"<CR>
inoremap <silent> <Up> <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"<CR>

" CTRL-F does Find dialog instead of page forward
noremap <silent> <C-F> :promptfind<CR>
vnoremap <silent> <C-F> y:promptfind <C-R>"<CR>
onoremap <silent> <C-F> <C-C>:promptfind<CR>
inoremap <silent> <C-F> <C-O>:promptfind<CR>
cnoremap <silent> <C-F> <C-C>:promptfind<CR>

set backspace=2		" allow backspacing over everything in insert mode
set autoindent		" always set autoindenting on

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set incsearch		" do incremental searching
set mouse=a		" always use the mouse

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Highlight the last used search pattern on the next search command.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  nohlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  au FileType text setlocal tw=78

endif " has("autocmd")
"--- evim end

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
"	set lines=55
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

" backspace and cursor keys wrap to previous/next line
"set backspace=indent,eol,start whichwrap+=<,>,[,]

" Allow backspace over everything
set backspace=indent,eol,start

" Wrap to the line above the current one when using arrow keys, backpsace
" and space character
"set whichwrap=b,s,<,>,[,]
set whichwrap=

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

" brief-home/end/pgup/pgdn
inoremap <silent> <Home> <C-O>:call <SID>BriefHomeKey()<CR>
inoremap <silent> <End> <C-O>:call <SID>BriefEndKey()<CR>
inoremap <silent> <PageUp> <C-O>:call <SID>BriefPageUp()<CR>
inoremap <silent> <PageDown> <C-O>:call <SID>BriefPageDown()<CR>

" linewise selections
inoremap <silent> <S-Down> <C-O>gH<S-Down>
inoremap <silent> <S-Up> <C-O>gH<S-Up>

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

"-----------------------
" Misc
"-----------------------
inoremap <A-h> <C-O>:help 

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

"-----------------------
" Functions
"-----------------------

" page up exactly one page without moving cursor position on screen
function! s:BriefPageUp()
   let l:a = getpos(".")
   execute "normal " . winheight(0) . "\<c-y>"
   let a[1] = a[1] - winheight(0)
   if (a[1] < 1) 
      let a[1] = 1
   endif
   call setpos(".",a)
endfunction

" page down exactly one page without moving cursor position on screen
function! s:BriefPageDown()
   let l:a = getpos(".")
   let l:dist = winheight(0)
   if (line(".") + winheight(0) > line("$"))
	  " page down would go past end of buffer
      let l:dist = line("$") - line(".") 
   else
   	  execute "normal " . l:dist . "\<c-e>"
   endif
   let a[1] = a[1] + l:dist
   call setpos(".",a)
endfunction

let b:homeline = 0
function! s:BriefHomeKey()
   " if we are on the first char of the line, go to the top of the screen
   if (col(".") <= 1 && line(".") == b:homeline)
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
	  let b:homeline = line(".")
   endif
endfunction

" This function is taken from vim online web page and modified
let b:endline = 0
function! s:BriefEndKey()
    let cur_col = virtcol(".")
    let line_len = virtcol("$")

	if cur_col != line_len || line(".") != b:endline
        " The cursor is not at the end of the line, goto the end of the line
        execute "normal " . line_len . "|"
		let b:endline = line(".")
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

