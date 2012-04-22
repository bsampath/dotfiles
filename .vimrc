" .vimrc files
"
" Author   : Shriram V
" Email    : shri314@yahoo.com
" Comments : This is .vimrc file adapted to integrate the make utils,
"            plus a lot of enhancements and settings to make the
"            editor exciting to use.
"
"
" use Vim defaults be used for options that have a different Vi and Vim default value.
" set nocompatible

set background=dark

" Turn on syntax highlighting
syntax on
highlight Comment term=bold ctermfg=lightblue guifg=#80o0ff gui=bold
highlight StatusLine       ctermfg=lightblue ctermbg=white
highlight StatusLineNC    ctermfg=gray ctermbg=black

" Ignore case in search patterns
set ignorecase

" Incremental Search
set incsearch

" Highlight search
set hlsearch

" Show ruler
set ruler

" Set the shell to use
set shell=bash

" Show brace matching as you edit
set showmatch

" Always show status line
set laststatus=2

" Shift width when you press << or >> to indent a line.
set shiftwidth=3

" Changes how backspace works.
set bs=2

" Expand Tab
set expandtab

" Number of spaces for a tab
set tabstop=3

" lines longer than the width of the window will not wrap
set wrap

" Searches does not wrap around the end of the file
set nowrapscan

"Not always equal
set noequalalways

" cindent will be on for all file types
autocmd BufNewFile,BufRead * set autoindent
autocmd BufNewFile,BufRead * set cindent
"autocmd BufNewFile,GUIEnter * simalt~x

" Set smart indent
set smartindent

" set backspace to ASCII delete
" set remove to ANSI remove
if &term=="linux" || &term=="xterm" || &term=="xterm-color"
  set t_kb=
  set t_kD=[3~
endif

"F11 to comment current line and go to next line
map <F11> 0i#<Esc>j
autocmd BufNewFile,BufRead *.vimrc,*.vim                                         map <buffer> <F11> 0i"<Esc>j
autocmd BufNewFile,BufRead *.java,*.c,*.h,*.C,*.cc,*.cpp,*.hpp,*.cxx,*.hxx,*.hh  map <buffer> <F11> 0i//<Esc>j

"Synatax Extension
syn match       MemberF      display "\<\h\w*\>\s*("me=e-1
highlight       MemberF      gui=bold term=bold
autocmd BufNewFile,BufRead *.java,*.c,*.h,*.C,*.cc,*.cpp,*.hpp,*.cxx,*.hxx,*.hh  syn match Member  "\<m_[_A-Za-z0-9]*\>"
autocmd BufNewFile,BufRead *.java,*.c,*.h,*.C,*.cc,*.cpp,*.hpp,*.cxx,*.hxx,*.hh  highlight Member  term=bold ctermfg=white gui=bold
autocmd BufNewFile,BufRead *.strace                                              set filetype=strace

function StubBeautify()
   echohl ErrorMsg | echo "Beautifier not configured..." | echohl None
endfunction

function BeautifyCpp()
   if executable('bcpp')
      normal msHmt
      %!bcpp -bnl -s -tbnl -i 3 -na -ylcnc -cc 33 2>/dev/null
      normal 'tzt`s
   else
      call StubBeautify()
   endif
endfunction

function BeautifyPerl()
   if executable('perltidy')
      normal msHmt
      %!perltidy -i=3 -nt -fnl -anl -bl -l=150 -bbs -bbc -bbb -mbl=2
      normal 'tzt`s
   else
      call StubBeautify()
   endif
endfunction

map <F12>b :call StubBeautify()<CR>
autocmd BufNewFile,BufRead *.cpp,*.h map <F12>b :call BeautifyCpp()<CR>
autocmd BufNewFile,BufRead *.pl,*.pm,*.cgi map <F12>b :call BeautifyPerl()<CR>

highlight       Member       gui=bold
syn match       Member       display "\<\h\w*\>\s*("me=e-1

set statusline=%t\ [%M]\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set nu

map OH ^
map OF $

"map [H ^
"map [F $
