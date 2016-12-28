" VIM customization "

" Terminal "
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
set t_Co=256
filetype plugin indent on
syntax on
set lines=52
set columns=120

" Tab to 4 spaces "
set tabstop=4
set shiftwidth=4
set expandtab
retab

" Misc "
set numberwidth=5         "Allow for 5 character buffer
set number                "Sets line numbers
set guifont=Consolas:h10  "Use Consolas, size 10
set cursorline            "Highlights the line you're on
set hlsearch              "Highlights the things you search
set showmatch             "Shows when {}, [], or () are matching
set titlestring=%t        "Only showing the current file for title
set history=1000          "Remember more commands
set undolevels=1000       "Remember more undo's
set visualbell            "No beeping
set noerrorbells          "No beeping
set nobackup              "No backup files
set noswapfile            "None of those stupid .swp files
set noundofile            "No annoying *un.~ files

" Clear highlight search "
nnoremap <esc><esc> :noh<return>

" Quit application "
inoremap <C-q> <esc>:qa!<cr>
nnoremap <C-q> :qa!<cr>

" Disable highlighting first comment in Javadoc "
let java_ignore_javadoc=1

" Color scheme "
set background=dark
colorscheme hybrid_material

" Removing GUI toolbar, scroller, etc. "
set guioptions-=m  "Remove menu bar
set guioptions-=T  "Remove toolbar
set guioptions-=r  "Remove right-hand scroll bar
set guioptions-=L  "Remove left-hand scroll bar

" Highlight characters that reside on the 100th character border "
augroup collumnLimit
  autocmd!
  autocmd BufEnter,WinEnter,FileType scala,java
        \ highlight CollumnLimit ctermbg=DarkGrey guibg=DarkGrey
  let collumnLimit = 101
  let pattern =
        \ '\%<' . (collumnLimit+1) . 'v.\%>' . collumnLimit . 'v'
  autocmd BufEnter,WinEnter,FileType scala,java
        \ let w:m1=matchadd('CollumnLimit', pattern, -1)
augroup END

" Disable spell check in Javadoc comments "
au BufRead,BufNewFile package.html source disable_javadoc_spellcheck.vim

" Set the diff "
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
