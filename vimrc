execute pathogen#infect()

" Cursor Movement Keys
" --------------------
" <Up>         - Move cursor up one line
" <Down>       - Move cursor down one line
" <C-Left>     - Goto beginning of previous word
" <C-Right>    - Goto beginning of next word
" <Home>       - Home key.  If you press once, cursor will move to the first
"                column in the current line.  If you press twice, cursor will
"                move to the first column in the first line in the current
"                page.  If you press thrice, cursor will be positioned at the
"                top of the file.
" <End>        - End key. If you press once, cursor will move to the last
"                column in the current line.  If you press twice, cursor will
"                move to the last column in the last line in the current page.
"                If you press thrice, cursor will be positioned at the end of
"                the file.
" <C-PageUp>   - Goto-beginning of file
" <C-PageDown> - goto-end of file
" <C-Home>     - Was beginning-of-window - Changed this to jump back
" <C-End>      - Was end-of-window       - changed this to jump fwd
" <C-d>        - Scroll line down
" <C-e>        - Scroll line up
" <A-Home>     - Move the cursor to the first character on screen
" <A-End>      - Move the cursor to the last character on screen
" <C-b>        - Move the current line to the bottom of the window
" <C-c>        - Move the current line to the center of the window
" <C-t>        - Move the current line to the top of the window
" 
" Editing Keys
" ------------
" <C-CR>       - Open a new line below the current line and goto that line
" <S-CR>       - open a new line below the current line, cursor stays in the
"                current line
" <A-i>        - Toggle insert mode
" <A-k>        - Delete from the cursor position to the end of line
" <C-k>        - Delete from the cursor position to the start of line
" <A-d>        - Delete the current line
" <kPlus>      - Copy line or mark to scrap buffer.  Vim register 'a' is used
"                as the scrap  buffer.
" <kMinus>     - Cut line or mark to scrap buffer.  Vim register 'a' is used
"                as the scrap buffer.
" <Ins>        - Paste scrab buffer contents to current cursor position.  Vim
"                register 'a' is used as the scrap buffer
" <C-Ins>      - Copy marked text to system clipboard.  If no mark, copy
"                current line
" <S-Ins>      - Paste the system clipboard contents to current cursor
" <S-Del>      - Cut the marked text to system clipboard. If no mark, cut the
"                current line
" <C-Del>      - Remove the marked text
" <C-v>        - Clipboard paste
" <A-g>        - Goto line
" <C-BS>       - Delete the previous word
" <A-BS>       - Delete the next word
" <A-/>        - Complete a partially typed word
" <A-q>        - Quote the next character
" 
" Delete Keys
" -----------
" <A-u>        - 
" <kMultiply>  - Undo last operation.  Either keypad * key or <A-u> can be
"                used.
" <A-y>        - Restore line
" <C-y>        - Redo the previously undid commands
" 
" Search and Replace Commands
" ---------------------------
" <C-f>        -
" <F5>         -
" <A-s>        - String search
" <S-F5>       - search again
" <A-F5>       - Reverse search
" <F6>         - Search and replace from the current cursor position
" <A-t>        - Search and replace the current word from the current cursor
"                position
" <S-F6>       - Repeat last search and replace
" <C-F5>       - toggle case sensitivity of search commands.
" 
" Buffer Commands
" ---------------
" <A-e>        - Open file
" <A-x>        - Exit
" <A-r>        - Read file
" <A-w>        - Save the current file
" <A-o>        - Save the current file in a different file name
" <A-n>        - Select next buffer from the buffer list
" <A-->        -
" <A-p>        - Select previous buffer from the buffer list
" <C-->        -
" <C-kMinus>   - Delete current buffer from buffer list
" <A-b>        - Display buffer list
" <A-f>        - Display buffer information
" 
" Compiler related commands
" -------------------------
" <A-F10>      - Compile current buffer
" <C-n>        - Jump to the next error
" <C-l>        - pJump to the next previous error
" <C-p>        - View compiler output
" 
" Mark commands
" -------------
" <A-m>        - Toggle standard text marking mode
" <A-l>        - Toggle line marking mode
" <A-c>        - 
" <A-a>        - Toggle column marking mode
" <A-h>        - Mark current word
" 
" Misc commands
" -------------
" <A-v>        - Show version
" <C-Up>
" <C-Down>     - Goto next/previous function
" <A-z>        - Start a shell
" <A-F1>       - Search for a keyword in online help
" 
" Bookmark
" --------
" <A-0>        - Mark bookmark 0
" <A-1>        - Mark bookmark 1
" <A-2>        - Mark bookmark 2
" <A-3>        - Mark bookmark 3
" <A-4>        - Mark bookmark 4
" <A-5>        - Mark bookmark 5
" <A-6>        - Mark bookmark 6
" <A-7>        - Mark bookmark 7
" <A-8>        - Mark bookmark 8
" <A-9>        - Mark bookmark 9
" <A-j>        - Jump to a bookmark
" 
" Windows Commands
" ----------------
" <F3>         - Split window
" <F4>         - Delete window
" <A-F2>       - Zoom window
" <A-Down>     - Goto the window below the current window
" <A-Up>       - Goto the window above the current window
"
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
"vnoremap <C-x> "+x

" CTRL-C is Copy
"vnoremap <C-c> "+y

" CTRL-V is Paste
"map <C-V>		"+gP
"cmap <C-V>		<C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

"exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
"exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" Use CTRL-Q to do what CTRL-V used to do
inoremap <C-Q>		<C-V>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
  set guioptions-=a
endif

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
"noremap <silent> <C-F> :promptfind<CR>
"vnoremap <silent> <C-F> y:promptfind <C-R>"<CR>
"onoremap <silent> <C-F> <C-C>:promptfind<CR>
"inoremap <silent> <C-F> <C-O>:promptfind<CR>
"cnoremap <silent> <C-F> <C-C>:promptfind<CR>

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
"	set columns=120

	" support alt key in 7-bit terminals like mintty
	let c='a'
	while c <= 'z'
	  exec "set <A-".c.">=\e".c
	  exec "imap \e".c." <A-".c.">"
	  let c = nr2char(1+char2nr(c))
	endw
"	let c='A'
"	while c <= 'Z'
"	  exec "set <A-".c.">=\e".c
"	  exec "imap \e".c." <A-".c.">"
"	  let c = nr2char(1+char2nr(c))
"	endw
	set notimeout
endif

" hide gui distractions
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

set tabstop=4
set shiftwidth=4

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
inoremap <silent> <S-Down> <C-O>gH
inoremap <silent> <S-Up> <C-O>gH

" goto-beginning of file
inoremap <silent> <C-PageUp> <C-O>gg

" goto-end of file
inoremap <silent> <C-PageDown> <C-O>G

" beginning-of-window
"inoremap <silent> <C-Home> <C-O>H

" end-of-window
"inoremap <silent> <C-End> <C-O>L

" go out or back (Ctrl-Home)
inoremap <silent> <C-Home> <C-O><C-O>

" go in or forward (Ctrl-End)
inoremap <silent> <C-End> <C-O><C-I>

" scroll line down
inoremap <silent> <C-d> <C-x><C-y>

" scroll line up
inoremap <silent> <C-e> <C-x><C-e>

" Move the cursor to the first character on screen
inoremap <silent> <A-Home> <C-O>g0

" Move the cursor to the last character on screen
inoremap <silent> <A-End> <C-O>g$

" Move the current line to the bottom of the window
inoremap <silent> <C-b> <C-O>z-

" Move the current line to the center of the window
"inoremap <silent> <C-c> <C-O>z.

" Move the current line to the top of the window
inoremap <silent> <C-t> <C-O>z<CR>

" select word - (shifted numpad-5)  --> TODO: further presses select line, block
exec "set <t_S5>=\e[1;2E"
imap <t_S5> <C-O>viW<C-g>

" hide selection - (numpad-5)
exec "set <t_K5>=\eOE"
imap <t_K5> <C-O>:nohl<CR>
smap <t_K5> <right><left>

" Ctrl-] to follow link
inoremap <C-]> <C-O><C-]>

"-----------------------
" Editing
"-----------------------

" Open a new line below the current line and goto that line
inoremap <silent> <C-CR> <C-O>o

" open a new line below the current line, cursor stays in the current line
inoremap <silent> <S-CR> <C-O>o<C-O>k

" Toggle insert mode
inoremap <silent> <A-i> <Ins>

" Delete from the cursor position to the end of line
inoremap <silent> <A-k> <C-O>d$

" Delete from the cursor position to the start of line
inoremap <silent> <C-k> <C-U>

" Delete the current line
inoremap <silent> <A-d> <C-O>dd

" Copy line or mark to scrap buffer.  Vim register 'a' is used as the scrap
" buffer
inoremap <silent> <kPlus> <C-O>"ayy
inoremap <silent> <C-c> <C-O>"ayy
vnoremap <silent> <kPlus> "ay
vnoremap <silent> <C-c> "ay

" Cut line or mark to scrap buffer.  Vim register 'a' is used as the scrap
" buffer
inoremap <silent> <kMinus> <C-O>"add
inoremap <silent> <C-x> <C-O>"add
vnoremap <silent> <kMinus> "ax
vnoremap <silent> <C-x> "ax

" Paste scrap buffer contents to current cursor position.  Vim register 'a' is
" used as the scrap buffer
inoremap <silent> <Ins> <C-O>"aP
inoremap <silent> <C-v> <C-O>"aP

" Copy marked text to system clipboard.  If no mark, copy current line
inoremap <silent> <C-Ins> <C-O>"*yy
vnoremap <silent> <C-Ins> "*y

" Paste the system clipboard contents to current cursor
inoremap <silent> <S-Ins> <C-O>"*P

" Cut the marked text to system clipboard. If no mark, cut the current line
inoremap <silent> <S-Del> <C-O>"*dd
vnoremap <silent> <S-Del> "*d

" Remove the marked text
vnoremap <silent> <Del> d

" Clipboard paste
"inoremap <silent> <C-v> <C-O>"*P

" Goto line
inoremap <silent> <A-g> <C-O>:call <SID>BriefGotoLine()<CR>

" Delete the previous word
inoremap <silent> <C-BS> <C-W>

" Delete the next word
inoremap <silent> <A-BS> <C-O>E<C-O>E<C-O>a<C-W>

" Complete a partially typed word
inoremap <silent> <A-/> <C-p>

" Quote the next character
inoremap <silent> <A-q> <C-v>

"-----------------------
" Delete
"-----------------------

" undo last operation.  Either keypad * key or <A-u> can be used
noremap <C-Z> u
inoremap <C-Z> <C-O>u
inoremap <silent> <A-u> <C-O>u
inoremap <silent> <kMultiply> <C-O>u

" Restore line
inoremap <silent> <A-y> <C-O>U

" Redo the previously undid commands
inoremap <silent> <C-y> <C-O>:redo<CR>

"-----------------------
" Search and replace
"-----------------------

" string-search
inoremap <silent> <C-f> <C-O>:call <SID>BriefSearch("")<CR>
inoremap <silent> <F5> <C-O>:call <SID>BriefSearch("")<CR>

inoremap <silent> <A-s> <C-O>:call <SID>BriefSearch(expand("<cword>")<CR>

" search again
inoremap <silent> <S-F5> <C-O>n
inoremap <silent> <C-n> <C-O>n

" Reverse search
inoremap <silent> <A-F5> <C-O>N
inoremap <silent> <C-p> <C-O>N

" Search and replace from the current cursor position
inoremap <silent> <F6> <C-O>:call <SID>BriefSearchAndReplace("")<CR>

" Search and replace the current word from the current cursor position
inoremap <silent> <A-t> <C-O>:call <SID>BriefSearchAndReplace(expand("<cword>"))<CR>

" Repeat last search and replace
inoremap <silent> <S-F6> <C-O>:.,$&&<CR>

" toggle case sensitivity of search commands.
inoremap <silent> <C-F5> <C-O>:set invignorecase<CR>

" Jump to matching brace or paren - (Ctrl-%)
exec "set <t_C5>=\e[1;5u"
inoremap <silent> <t_C5> <C-O>%

" Search forward for word under cursor - (Ctrl-*)
exec "set <t_C8>=\e[1;5x"
inoremap <silent> <t_C8> <C-O>*

" Search backward for word under cursor - (Shift-Ctrl-*)
exec "set <t_C*>=\e[1;6x"
inoremap <silent> <t_C*> <C-O>#

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
" Compiler related
"-----------------------
" compile-buffer
inoremap <silent> <A-F10> <C-O>:make<CR>

" next-error
"inoremap <silent> <C-n> <C-O>:cnext<CR>

" previous error
"inoremap <silent> <C-l> <C-O>:cprevious<CR>

" View compiler output
"inoremap <silent> <C-p> <C-O>:copen<CR>

"-----------------------
" Mark
"-----------------------

" toggle standard text marking mode
inoremap <silent> <A-m> <C-O>v
vnoremap <silent> <A-m> v

" Toggle line marking mode
inoremap <silent> <A-l> <C-O>V
vnoremap <silent> <A-l> V

" Toggle column marking mode
inoremap <silent> <A-c> <C-O><C-V>
inoremap <silent> <A-a> <C-O><C-V>
vnoremap <silent> <A-c> <C-V>
vnoremap <silent> <A-a> <C-V>

" Mark current word
inoremap <silent> <A-h> <C-O>viw

"-----------------------
" Misc commands
"-----------------------

" show version
inoremap <silent> <A-v> <C-O>:version<CR>

" Goto next/previous function
inoremap <silent> <C-Up>    <C-O>[[
inoremap <silent> <C-Down>  <C-O>]]

" Start shell
inoremap <silent> <A-z> <C-O>:stop<CR>

" Search for a keyword in the online help
inoremap <A-F1> <C-O>:help  

" Alt-h for help
inoremap <A-h> <C-O>:help 

"-----------------------
" Bookmark
"-----------------------

" Mark bookmark 0
inoremap <silent> <A-0> <C-O>mb

" Mark bookmark 1
inoremap <silent> <A-1> <C-O>mc

" Mark bookmark 2
inoremap <silent> <A-2> <C-O>md

" Mark bookmark 3
inoremap <silent> <A-3> <C-O>me

" Mark bookmark 4
inoremap <silent> <A-4> <C-O>mf

" Mark bookmark 5
inoremap <silent> <A-5> <C-O>mg

" Mark bookmark 6
inoremap <silent> <A-6> <C-O>mh

" Mark bookmark 7
inoremap <silent> <A-7> <C-O>mi

" Mark bookmark 8
inoremap <silent> <A-8> <C-O>mj

" Mark bookmark 9
inoremap <silent> <A-9> <C-O>mk

" Jump to a bookmark
inoremap <silent> <A-j> <C-O>:call <SID>BriefJumpMark()<CR>

"-----------------------
" Windows
"-----------------------

" Split window
inoremap <silent> <F3> <C-O>:split<CR>

" Delete window
inoremap <silent> <F4> <C-O>:quit<CR>

" Zoom window
inoremap <silent> <A-F2> <C-O>:only<CR>

" Goto the window below the current window
inoremap <silent> <A-Down> <C-O><C-W>w

" Goto the window above the current window
inoremap <silent> <A-Up> <C-O><C-W>W

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

function! s:BriefSearch(pattern)
    if has("gui_running")
        if a:pattern == ""
            promptfind
        else
            execute "promptfind " . a:pattern
        endif
    else
        let searchstr = input("Find text: ", a:pattern)
        if searchstr == ""
            return
        endif

        execute '/' . searchstr
    endif
endfunction

function! s:BriefSearchAndReplace(pattern)
    if has("gui_running")
        if a:pattern == ""
            execute "promptrepl " . a:pattern
        else
            promptrepl
        endif
    else
        let searchstr = input("Find text: ", a:pattern)
        if searchstr == ""
            return
        endif

        let replacestr = input("Replace with: ")
        if replacestr == ""
            return
        endif

        execute '.,$substitute/' . searchstr . '/' . replacestr . '/c'
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

function! s:BriefJumpMark()
    let mark = input("Jump to bookmark: ")
    if mark == ""
        return
    endif
    if mark == "0"
        normal `b
    endif
    if mark == "1"
        normal `c
    endif
    if mark == "2"
        normal `d
    endif
    if mark == "3"
        normal `e
    endif
    if mark == "4"
        normal `f
    endif
    if mark == "5"
        normal `g
    endif
    if mark == "6"
        normal `h
    endif
    if mark == "7"
        normal `i
    endif
    if mark == "8"
        normal `j
    endif
    if mark == "9"
        normal `k
    endif
endfunction

function! s:BriefGotoLine()
    let linenr = input("Line number to jump to: ")
    if linenr == ""
        return
    endif

    execute "normal " . linenr . "gg"
endfunction

