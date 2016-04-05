execute pathogen#infect()

set encoding=utf8

"-----------------------
" De-modalize
"-----------------------

" Modeless operation, stay in insert mode.
" Use CTRL-O for one normal vi command
" Use CTRL-L for multiple normal vi commands
set nocompatible
set insertmode

"-----------------------
" Mouse
"-----------------------

" allow mouse to start select mode
set selectmode+=mouse
set mousemodel=popup
set mouse=a             " always use the mouse


"-----------------------
" Color
"-----------------------

" Switch syntax highlighting on, when the terminal has colors
" Highlight the last used search pattern on the next search command.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  nohlsearch
endif

if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal tw=78
endif

syntax enable
colo gc


"-----------------------
" Virtual Editing
"-----------------------

set virtualedit=all             " virtual edit in all modes
set backspace=indent,eol,start  " allow backspace over any boundary
set whichwrap=                  " do not let <Left> or <Right> cursor movement wrap
set nowrap                      " do not wrap lines


"-----------------------
" Alt as modifier key (key to the left of the space bar)
"-----------------------

if has("gui_running")
    au GUIEnter * simalt ~x
else
"   set lines=55
"   set columns=120

    " support alt key in 7-bit terminals like mintty
    let c='a'
    while c <= 'z'
      exec "set <A-".c.">=\e".c
"      exec "imap \e".c." <A-".c.">"
      let c = nr2char(1+char2nr(c))
    endw
    let c='0'
    while c <= '9'
      exec "set <A-".c.">=\e".c
"      exec "imap \e".c." <A-".c.">"
      let c = nr2char(1+char2nr(c))
    endw
    set notimeout

    " --- The following should let both <Esc> and the alt keys to work, but instead it
    "  breaks the alt keys.
    "
    "set ttimeout
    "set timeoutlen=1000
    "set noesckeys
endif

" mintty application escape key mode - fixes having to hit <Esc> twice
" see https://code.google.com/p/mintty/wiki/Tips#Avoiding_escape_timeout_issues_in_vim
" also http://code.google.com/p/mintty/wiki/CtrlSeqs
let &t_ti.="\e[?7727h"
let &t_te.="\e[?7727l"
noremap <Esc>O[ <Esc>
noremap! <Esc>O[ <Esc>

"-----------------------
" De-guify
"-----------------------

set winaltkeys=no
set guioptions-=T   " no toolbar
set guioptions-=r   " right hand scrollbar always present
set guioptions-=L   " left hand scrollbar present on vertical split
set guioptions-=m   " menu bar is present
set guioptions-=M   " no menu.vim
set guioptions+=c   " disable popups

set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI
set number
set guicursor=n-v-c:block-Cursor/lCursor,ve:hor13-Cursor,o:hor50-Cursor,i-ci:hor13-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
hi Cursor guifg=white guibg=red

"-----------------------
" Misc
"-----------------------

set laststatus=2    " Always have a status line
set hidden          " Make a buffer hidden when editing another one
set autoindent      " always set autoindenting on
set history=50      " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set incsearch       " do incremental searching

let mapleader=','

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
set expandtab

set backup
set backupdir=~/.vimfiles

"autocmd InsertCharPre * nested match none
" clear highlights for searches and jumps
set updatetime=300
autocmd CursorHoldI * nested match none

"-----------------------
" Restore session:  Go to last file(s) if invoked without arguments.
" autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim/Session.vim") |
"-----------------------
autocmd VimEnter * nested if len(bufname("%")) == 0 && filereadable($HOME . "/.vim/Session.vim") |
   \ execute "source " . $HOME . "/.vim/Session.vim"  |
   \ endif

autocmd VimEnter * nested if bufname("%") == "_nofile_" |
   \ bd |
   \ endif

autocmd VimLeave * nested if (!isdirectory($HOME . "/.vim")) |
   \ call mkdir($HOME . "/.vim") |
   \ endif |
   \ if !exists("g:SoyWikiLoaded") |
   \ execute "mksession! " . $HOME . "/.vim/Session.vim" |
   \ endif

" highlight tabs and trailing whitespace
highlight RedundantWhitespace ctermbg=red guibg=red
match RedundantWhitespace /\s\+$\|\t/

"-----------------------
" tags: search for tags in local directory, going up to parent dirs if needed
"-----------------------
set tags=./build/tags,../build/tags,../../build/tags,../../../build/tags,../../../../build/tags,../../../../../build/tags,./tags;src
set tr

"------------------
" Shift to select
"------------------

" Use visual mode for selections (does not auto-delete on text entry)
" Left or right for character selection ("v" mode)
" Up or down for line selection ("V" mode)

set keymodel=startsel,stopsel
set selection=exclusive

" start character selections using shifted left/right arrows
inoremap <silent> <S-Left> <C-O>:<C-u>set selection=exclusive<CR><S-Left>
inoremap <silent> <S-Right> <C-O>:<C-u>set selection=exclusive<CR><S-Right>

" start linewise selections using shifted up/down arrows
" --> TODO: pgup/pgdn/home/end
inoremap <silent> <S-Down> <C-O>V
inoremap <silent> <S-Up> <C-O>V

" backspace in Visual mode deletes selection
vnoremap <BS> d

"change cursor to block inside selections to hide the fact that cursor overrides highlight
if !has("gui_running")
let &t_ti.="\e[2 q"
let &t_EI.="\e[2 q"
let &t_SI.="\e[3 q"
let &t_te.="\e[0 q"
function s:Cursor_Moved()
   if mode("") == "v"
     if line(".") > line("v") || (line(".") == line("v") && virtcol(".") >= virtcol("v"))
       " cursor outside of char selection, so use underbar cursor
       let l:cursor=1
     else
       " cursor within char selection, so use block cursor
       let l:cursor=2
     endif
   else
     let l:cursor=2
   endif

   if !exists("b:lastcursor") || l:cursor != b:lastcursor
       if l:cursor == 1
           " underbar
           silent !echo -ne "\e[3 q"
       else
           " block
           silent !echo -ne "\e[2 q"
       endif
   endif

   let b:lastcursor = l:cursor
endfunction
autocmd CursorMoved * if mode("") != "i" | call s:Cursor_Moved() | endif
autocmd InsertEnter * let b:lastcursor = 0
endif

" shrink selection - (shifted numpad-5)  --> TODO: further presses select line, block
exec "set <t_S5>=\e[1;2E"
inoremap <t_S5> <Nop>
vnoremap <t_S5> <C-C>

" grow selection - (numpad-5)  --> TODO: further presses select line, block
exec "set <t_K5>=\eOE"
imap <t_K5> <C-O>viwo
vnoremap <t_K5> <Nop>

" toggle standard text marking mode  --> TODO: force selection=exclusive
inoremap <silent> <A-a> <C-O>v
vnoremap <silent> <A-a> v
inoremap <silent> <A-m> <C-O>v
vnoremap <silent> <A-m> v

" Toggle line marking mode
inoremap <silent> <A-l> <C-O>V
vnoremap <silent> <A-l> V

" Why is this not working in mintty????
" Start column marking mode   --> TODO: make it toggle instead
"inoremap <silent> <A-c> <C-O><C-V>:<C-u>set selection=inclusive<CR><C-O>gv<C-v>
"vnoremap <silent> <A-c> <C-V>:<C-u>set selection=inclusive<CR><C-O>gv
"vnoremap <silent> <A-c> :<C-u>set selection=inclusive<CR><C-O>gv<C-v>
inoremap <silent> <A-c> <c-o><c-v>
vnoremap <silent> <A-c> :<C-u>call <SID>ColumnSelection()<CR>
vnoremap <silent> <S-c> :<C-u>call <SID>ColumnSelection()<CR>

function! s:ColumnSelection()
     exe "normal! gv"
     if line(".") > line("v") || (line(".") == line("v") && virtcol(".") >= virtcol("v"))
       " cursor outside of char selection
       let l:right=1
     else
       " cursor within char selection
       let l:right=0
     endif
    if visualmode() == ""
        " go to char selection
        set selection=exclusive
        if l:right == 1
            exe "normal! gvv\<s-Right>"
        else
            exe "normal! gvvo\<s-Right>o"
        endif
    elseif visualmode() == "V"
        " go to column selection
        set selection=inclusive
        exe "normal! gv\<c-v>"
    else
        " go to column selection
        set selection=inclusive
        if l:right == 1
            exe "normal! gv\<c-v>\<s-Left>"
        else
            exe "normal! gv\<c-v>o\<s-Left>o"
        endif
    endif
endfunction

" Mark current word
"inoremap <silent> <A-h> <C-O>viw

" CTRL-A is Select all (or should we make it beginning of line? Eg., Ctrl-aefbd)
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" Indent or outdent a selection
"vnoremap <Tab> >
"vnoremap <S-Tab> <
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" CTRL-W to wrap text (reflow paragraph)
inoremap <silent> <C-W> <C-O>gqap
:command Format %!astyle -A1

" delete word (ctrl-backspace)
inoremap <silent> <C-_> <C-W>

"-----------------------
" Copy/Paste from clipboard using CTRL-X, CTRL-C and CTRL-V
"-----------------------

" Don't autoselect (automatically copy selection to clipboard)
if !has("unix")
  set guioptions-=a
endif

" Use CTRL-X, CTRL-C and CTRL-V for cut, copy and paste
" Use CTRL-BREAK to stop (What CTRL-C used to do)
" Use ALT-Q to enter literal characters (what CTRL-V used to do)
inoremap <C-q>  <C-v>
inoremap <silent> <A-q> <C-v>
if has('clipboard')
  vnoremap <silent> <C-x> "*x
  vnoremap <silent> <C-c> "*ygv
  vnoremap <silent> <C-v> "*Pgv<S-right>y
  inoremap <silent> <C-v> <C-O>"+P
  cnoremap <C-V>     <C-R>+
else
  " cut/copy/paste for OSX terminal, local vim with no built-in clipboard support
  vnoremap <silent> <C-x> "axi<C-R>=system("pbcopy",@a)?'':''<CR>
  vnoremap <silent> <C-c> "ayi<C-R>=system("pbcopy",@a)?'':''<CR><C-O>gv
  vnoremap <silent> <C-v> x<C-R>=system("pbpaste")<CR>
  inoremap <silent> <C-v> <C-R>=system("pbpaste")<CR>
  inoremap <silent> <C-v> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
  cnoremap <C-v> <C-R>=system("pbpaste")<CR>
endif


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
"inoremap <silent> <Down> <C-O>gj
"inoremap <silent> <Up> <C-O>gk

" goto beginning of previous word
inoremap <silent> <C-Left> <C-O>B

" goto beginning of next word
inoremap <silent> <C-Right> <C-O>W

" brief-home/end/pgup/pgdn
inoremap <silent> <Home> <C-O>:call <SID>BriefHomeKey()<CR>
inoremap <silent> <End> <C-O>:call <SID>BriefEndKey()<CR>
inoremap <silent> <PageUp> <C-O>:call <SID>BriefPageUp()<CR>
inoremap <silent> <PageDown> <C-O>:call <SID>BriefPageDown()<CR>

" goto-beginning of file - conflicts with vim prev-tab
"inoremap <silent> <C-PageUp> <C-O>gg

" goto-end of file - conflicts with vim next-tab
"inoremap <silent> <C-PageDown> <C-O>G

" beginning-of-window
inoremap <silent> <C-Home> <C-O>H

" end-of-window
inoremap <silent> <C-End> <C-O>L

" scroll line down
"inoremap <silent> <C-d> <C-x><C-y>  " prevents scrolling when cursor hits bottom
inoremap <silent> <C-d> <C-O><C-y>

" scroll line up
"inoremap <silent> <C-e> <C-x><C-e>  " prevents scrolling when cursor hits top
inoremap <silent> <C-e> <C-O><C-e>

" Move the cursor to the first character on screen
inoremap <silent> <A-Home> <C-O>g0

" Move the cursor to the last character on screen
inoremap <silent> <A-End> <C-O>g$

" Goto next/previous function
inoremap <silent> <C-Up>    <C-O>[[
inoremap <silent> <C-Down>  <C-O>]]

" Move the current line to the bottom of the window
inoremap <silent> <C-b> <C-O>z-

" Move the current line to the center of the window
"inoremap <silent> <C-c> <C-O>z.

" Move the current line to the top of the window
inoremap <silent> <C-t> <C-O>z<CR>

" go out  (Keypad*)
inoremap <silent> <kMultiply> <C-O><C-I>
"inoremap <silent> <kMultiply> <C-O>:call <SID>FollowOrJumpNext()<CR>
"inoremap <silent> <kMultiply> <C-O><C-I>
inoremap <kMultiply> <C-O><C-O>
snoremap <kMultiply> <left><right><C-O>

" go in or forward (S-Keypad*)
exec "set <t_k/>=\e[1;2j"
inoremap <S-kMultiply> <C-O><C-I>
inoremap <silent> <t_k/> <C-O><C-I>

" follow link (Ctrl-] or Keypad-enter)
inoremap <C-]> <C-O><C-]>
"inoremap <C-kMultiply> <C-O><C-]>
exec "set <t_l/>=\e[1;5j"
inoremap <silent> <t_l/> <C-O><C-]>

" Keypad enter to follow link
inoremap <kEnter> <C-O><C-]><C-O>zz

"-----------------------
" Editing
"-----------------------

" Open a new line below the current line and goto that line
inoremap <silent> <C-^> <C-O>o

" open a new line below the current line, cursor stays in the current line
"inoremap <silent> <S-CR> <C-O>o<C-O>k

" Toggle insert mode
inoremap <silent> <A-i> <Ins>

" Delete from the cursor position to the end of line
inoremap <silent> <A-k> <C-O>d$

" Delete from the cursor position to the start of line
inoremap <silent> <C-k> <C-U>

" Delete the current line
inoremap <silent> <A-d> <C-O>dd

" Copy line or mark to scrap buffer.  Vim register 'a' is used as the scrap
" buffer, register '+' is the system clipboard.
inoremap <silent> <kPlus> <C-O>"ayy
inoremap <silent> <C-c> <Nop>
vnoremap <silent> <kPlus> "ay

" Cut line or mark to scrap buffer.  Vim register 'a' is used as the scrap
" buffer, register '+' is the system clipboard.
inoremap <silent> <kMinus> <C-O>"add
inoremap <silent> <C-x> <Nop>
vnoremap <silent> <kMinus> "ax

" Paste scrap buffer contents to current cursor position.  Vim register 'a' is
" used as the scrap buffer
inoremap <silent> <Ins> <C-O>"aP
vnoremap <silent> <Ins> "aP
imap <S-Insert> <C-V>
vmap <S-Insert> <C-V>

"
" Copy marked text to system clipboard.  If no mark, copy current line
inoremap <silent> <C-Ins> <C-O>"*yy vnoremap <silent> <C-Ins> "*y

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

"-----------------------
" Delete
"-----------------------

" undo last operation.  Either (CTRL-Z) or (ALt-U) can be used
noremap <C-Z> u
inoremap <C-Z> <C-O>u
inoremap <silent> <A-u> <C-O>u

" Restore line
inoremap <silent> <A-y> <C-O>U

" Redo the previously undid commands  (CTRL-Y)
inoremap <silent> <C-y> <C-O>:redo<CR>

"-----------------------
" Search and replace
"-----------------------

" string-search
inoremap <silent> <C-f> <C-O>:call <SID>BriefSearch("")<CR>
inoremap <silent> <A-s> <C-O>:call <SID>BriefSearch("")<CR>
inoremap <silent> <F5> <C-O>:call <SID>BriefSearch("")<CR>
"inoremap <silent> <A-s> <C-O>:call <SID>BriefSearch(expand("<cword>")<CR>
"inoremap <C-f> <C-O>/
"TODO- implement this
vnoremap <silent> <C-f> <Nop>

" letter search
"inoremap <silent> <C-f> <C-O>f
"inoremap <silent> <C-F> <C-O>F

" search again
inoremap <silent> <S-F5> <C-O>:call <SID>BriefSearchAgain()<CR>
inoremap <silent> <C-N> <C-O>:call <SID>BriefSearchAgain()<CR>
vnoremap <silent> <C-N> <right><left>:call <SID>BriefSearchAgain()<CR>

" Reverse search
inoremap <silent> <A-F5> <C-O>:call <SID>BriefSearchAgainBack()<CR>
inoremap <silent> <C-p> <C-O>:call <SID>BriefSearchAgainBack()<CR>
vnoremap <silent> <C-p> <right><left>:call <SID>BriefSearchAgainBack()<CR>

" Search and replace from the current cursor position
inoremap <silent> <F6> <C-O>:call <SID>BriefSearchAndReplace("")<CR>

" Search and replace the current word from the current cursor position
inoremap <silent> <A-t> <C-O>:call <SID>BriefSearchAndReplace(expand("<cword>"))<CR>

" Repeat last search and replace
inoremap <silent> <S-F6> <C-O>:.,$&&<CR>

" toggle case sensitivity of search commands.
inoremap <silent> <C-F5> <C-O>:set invignorecase<CR>

" Search forward for word under cursor - (/)  TODO - use other search method
inoremap <silent> <kDivide> <C-O>*<C-O>:nohl<CR><C-O>viwo<C-g>
snoremap <silent> <kDivide> <right><left>*:nohl<CR>viwo<C-g>
vnoremap <silent> <kDivide> <C-g><right><left>*:nohl<CR>viwo<C-g>

" Search backward for word under cursor - (Shift-/)
exec "set <t_~*>=\e[1;2o"
inoremap <silent> <t_~*> <C-O>#<C-O>:nohl<CR><C-O>viwo<C-g>
inoremap <silent> <S-kDivide> <C-O>#<C-O>:nohl<CR><C-O>viwo<C-g>
snoremap <silent> <t_~*> <right><left>#:nohl<CR>viwo<C-g>
snoremap <silent> <S-kDivide> <right><left>#:nohl<CR>viwo<C-g>
vnoremap <silent> <t_~*> <C-g><right><left>#:nohl<CR>viwo<C-g>
vnoremap <silent> <S-kDivide> <C-g><right><left>#:nohl<CR>viwo<C-g>

" Jump to matching brace or paren - (Ctrl-/)
exec "set <t_C5>=\e[1;5o"
inoremap <silent> <t_C5> <C-O>%

"-----------------------
" Buffer
"-----------------------

" open file
inoremap <A-e> <C-O>:edit<space>
vnoremap <A-e> <right><left>:edit<space>

" exit
inoremap <silent> <A-x> <C-O>:confirm quit<CR>
vnoremap <silent> <A-x> <right><left>:confirm quit<CR>

" close single window
inoremap <silent> <A-s> <C-O>:bd<CR>
vnoremap <silent> <A-s> <right><left>:bd<CR>

" read file
inoremap <A-r> <C-O>:read<space>

" Save the current file
inoremap <silent> <A-w> <C-O>:call <SID>BriefSave()<CR>
vnoremap <silent> <A-w> <left><right>:call <SID>BriefSave()<CR>

" Save the current file in a different file name
inoremap <silent> <A-o> <C-O>:call <SID>BriefSaveAs()<CR>

" Select next buffer from the buffer list
inoremap <silent> <A-n> <C-O>:bnext<CR>
snoremap <silent> <A-n> <right><left>:bnext<CR>

" Select previous buffer from the buffer list
"inoremap <silent> <A--> <C-O>:bprevious<CR>
inoremap <silent> <A-p> <C-O>:bprevious<CR>
snoremap <silent> <A-p> <right><left>:bprevious<CR>

" Delete current buffer from buffer list
"inoremap <silent> <C--> <C-O>:bdelete<CR>
"inoremap <silent> <C-kMinus> <C-O>:bdelete<CR>

" Display buffer list
inoremap <A-b> <C-O>:buffers<CR>

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
" Misc commands
"-----------------------

" show version
inoremap <silent> <A-v> <C-O>:version<CR>
snoremap <silent> <A-v> <right><left>:version<CR>

" Start shell
inoremap <silent> <A-z> <C-O>:stop<CR>

" Help (Alt-h) - the vnoremap version returns to the same place
"inoremap <A-h> <C-O>:tab help<space>
inoremap <A-h> <C-O>:help<space>
vnoremap <A-h> "cy<C-O>gv:<C-u>help <C-R>c<CR>

" Command (F10)
imap <F10> <C-O>:
smap <F10> <C-O>:

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

" Zoom window (Alt-F2)
inoremap <silent> <A-F2> <C-O>:resize<CR>
exec "set <t_~2>=\e[1;3Q"
inoremap <silent> <t_~2> <C-O>:call <SID>BriefZoomWindow()<CR>

" Goto the window below the current window (Alt-down, or Ctrl-Alt-Numpad-down)
inoremap <silent> <A-Down> <C-O><C-W>j
exec "set <t_~u>=\e[1;7B"
inoremap <silent> <t_~u> <C-O><C-W>j

" Goto the window above the current window (Alt-up, or Ctrl-Alt-Numpad-up)
inoremap <silent> <A-Up> <C-O><C-W>k
exec "set <t_~d>=\e[1;7A"
inoremap <silent> <t_~d> <C-O><C-W>k

" Move around splits with <c-hjkl>
"nnoremap <c-h> <c-w>h
"nnoremap <c-j> <c-w>j
"nnoremap <c-k> <c-w>k
"nnoremap <c-l> <c-w>l

"-----------------------
" Functions
"-----------------------

" brief home key goes to beginning of line on first press, first line of screen
" on second press, and beginning of buffer on third press
function! s:BriefHomeKey()
   " have we jumped to the start of the line already?
   if col(".") > 1 || !exists("b:wentsol") || line(".") != b:wentsol
      " we didn't just jump to the start of this line, so do it now
      normal 0
      let b:wentsol = line(".")
   else
      " we recently jumped to the start of this line, so go to start of screen
      let l:a = line(".")
      normal H0
      if line(".") != l:a
         " we went to start of screen
         let b:wentsol = line(".")
      else
         " jumping to start of screen did not move, so go to start of buffer
         normal 1G
      endif
   endif
endfunction

" brief end key goes to end of line on first press, last line of screen
" on second press, and end of buffer on third press
function! s:BriefEndKey()
    let cur_col = virtcol(".")
    let line_len = virtcol("$")

    if !exists("b:wenteol") || cur_col != line_len || line(".") != b:wenteol
        " The cursor is not at the end of the line, so go to the end of the line
        execute "normal " . line_len . "|"
        let b:wenteol = line(".")
    else
        " cursor is already at the end of the line, so go to end of screen
        let cur_line = line(".")
        normal L
        if line(".") != cur_line
            " moved to end of screen, so now go to the end of the line
            let line_len = virtcol("$")
            if line_len > 0
                execute "normal " . line_len . "|"
            endif
            let b:wenteol = line(".")
        else
            " jumping to end of screen did not move, so go to end of buffer
            normal G
            let line_len = virtcol("$")
            if line_len > 0
                execute "normal " . line_len . "|"
            endif
        endif
    endif
endfunction

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

" toggle zoom window size to maximum
" TODO: use :only to zoom, and mksession to restore
function! s:BriefZoomWindow()
   let l:h = winheight(0)
   resize
   if (l:h == winheight(0))
       " could not zoom, so unzoom
       if (exists("w:restoreHeight"))
          execute "resize" w:restoreHeight
          unlet w:restoreHeight
       endif
   else
       " zoomed
       if (!exists("w:restoreHeight"))
           let w:restoreHeight = l:h
       endif
   endif
endfunction

" brief search prompts for text, then goes forward to that text
function! s:BriefSearch(pattern)
    let searchstr = input("Find text: ", a:pattern)
    if searchstr == ""
        echo "\rFind cancelled                   "
        return
    endif


    let [lll, ccc] = searchpos(searchstr,'c')
    if lll == 0 && ccc == 0
        echo "\rPattern not found.                   "
        return
    endif
    let cc = ccc - 1
    let ee = ccc + len(searchstr) + 1
"        execute 'normal /.*'
     highlight SearchResults ctermbg=blue guibg=blue
     execute 'match SearchResults /\%' . lll . 'l\%>' . cc . 'c.\%<' . ee . 'c/'
     call s:MaybeMiddle()

     let @/ = searchstr

     execute "normal :<BS>"| "clear command window
endfunction

function! s:BriefSearchAgain()
        let searchstr = @/

        if searchstr == ""
            return
        endif

        let [lll, ccc] = searchpos(searchstr,'')
        if lll == 0 && ccc == 0
            echo "\rPattern not found.                   "
            return
        endif
        let cc = ccc - 1
        let ee = ccc + len(searchstr) + 1
        highlight SearchResults ctermbg=blue guibg=blue
        execute 'match SearchResults /\%' . lll . 'l\%>' . cc . 'c.\%<' . ee . 'c/'
    call s:MaybeMiddle()
endfunction

function! s:BriefSearchAgainBack()
        let searchstr = @/

        if searchstr == ""
            return
        endif

        let [lll, ccc] = searchpos(searchstr,'b')
        if lll == 0 && ccc == 0
            echo "\rPattern not found.                   "
            return
        endif
        let cc = ccc - 1
        let ee = ccc + len(searchstr) + 1
        highlight SearchResults ctermbg=blue guibg=blue
        execute 'match SearchResults /\%' . lll . 'l\%>' . cc . 'c.\%<' . ee . 'c/'
    call s:MaybeMiddle()
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
            echo "\rFind cancelled                   "
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
"        if has("gui_running")
"            browse write
"        else
            let fname = input("Save file as: ")
            if fname == ""
                return
            endif
            execute "write " . fname
"        endif
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
        echo "\rJump to bookmark cancelled     "
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
    highlight SearchResults ctermbg=blue guibg=blue
    execute 'match SearchResults /\%' . line('.') . 'l/'
    echo ""
endfunction

function! s:BriefGotoLine()
    let linenr = input("Line number to go to: ")
    if linenr == ""
        echo "\rGo to line cancelled     "
        return
    endif

    execute "normal " . linenr . "gg"

    highlight SearchResults ctermbg=blue guibg=blue
    execute 'match SearchResults /\%' . line('.') . 'l/'
    call s:MaybeMiddle()
    echo ""
endfunction

" If cursor is in first or last line of window, scroll to middle line.
function s:MaybeMiddle()
  if winline() == 1 || winline() == winheight(0)
    normal! zz
  endif
endfunction

inoremap <C-e> <C-v>
cmap <Esc> <Esc><c-o>:echo "foo"<CR>

" configure airline, set theme to dark to fix vim returning error code
let g:airline_theme='dark'
let g:airline_powerline_fonts = 1
set noshowmode " don't show mode on command line
set lazyredraw " don't flicker modes during insert mode navigation
let g:airline_section_z = airline#section#create(['%3p%% ',
           \ 'linenr', ':%3c-%-3v']) " add virtual column number

function! Browser ()
  let line = matchstr(getline("."), 'link:[^[#]*')
  if (line != "")
      exec "edit ".strpart(line,5)
      return
  endif

  let line = matchstr(getline("."), 'https\=:\/\/[^ >,;]*')
  if (line == "")
      echo ""
      exec "normal! <c-]>"
  else
      echo ""
      exec "silent !/cygdrive/c/Program\\ Files\\ \\(x86\\)/Mozilla\\ Firefox/firefox.exe -new-window ".line." &>/dev/null &" | redraw!
  endif
endfunction
imap <c-]> <c-o>:call Browser ()<CR>

" Either jump to the next item in jump list, or follow link
function! s:FollowOrJumpNext()
  redir => l:jumpsOutput
  silent! execute 'jumps'
  redir END
  redraw " This is necessary because of the :redir done earlier.
  let l:jumplines = split(l:jumpsOutput, "\n")[1:] " The first line contains the header.

  echo jumplines[-1]

  if l:jumplines[-1][0] ==# '>'
     exec "normal! \<C-]>"
  else
     exec "normal! 1\<C-i>"
  endif
endfunction

au BufNewFile,BufRead *.adoc set filetype=asciidoc
au BufNewFile,BufRead *.adoc set textwidth=80
au BufNewFile,BufRead *.ad set filetype=asciidoc
au BufNewFile,BufRead *.ad set textwidth=80

