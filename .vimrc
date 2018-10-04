set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'dracula/vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rust-lang/rust.vim'
call vundle#end()            " required

let NERDTreeShowHidden=1

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_w = 1
let g:syntastic_check_on_wq = 0

color dracula

set tabstop=2
set expandtab
set colorcolumn=101
set shiftwidth=2
set number
set backspace=indent,eol,start
set mouse=a
set bg=light
set backup
set backupdir=~/.backup
set directory=~/.vimswap
set splitright
set splitbelow
set clipboard=unnamed
set sidescroll=1
set nowrap

" reize window if too small
set columns=130
set lines=45

" use mac terminal's cursor
if has('macunix')
  let &t_SI.="\e[5 q"
  let &t_SR.="\e[4 q"
  let &t_EI.="\e[1 q"
endif

filetype plugin indent on
syntax on

" add nerdtree explorer automatically (optional, uncomment below)
" autocmd VimEnter * NERDTree .
" autocmd VimEnter * wincmd w

" Ctrl+P opens up project view
silent! noremap <C-p> :NERDTreeToggle<CR>

" Alt-t in normal mode opens up terminal window
if has('macunix')
  nnoremap † :vert term<CR>
else
  nnoremap <A-t> :vert term<CR>
endif

" Tab/Shift-Tab in insert/visual mode for indents 
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
inoremap <S-Tab> <C-d>

"C+j/k to move text up/down
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==

" shift + direction for sideways scrolling
nnoremap <S-l> zl
nnoremap <S-h> zh
nnoremap <S-Right> zl
nnoremap <S-Left> zh

" change column limit to 80 characters for ocaml/haskell files
autocmd FileType ocaml,haskell setlocal colorcolumn=81

if has('terminal')
  function! ExitNormalMode()
    if &buftype == 'terminal' && mode('') == 'n'
        unmap <buffer> <silent> <RightMouse>
        call feedkeys("a")
    endif
  endfunction

  function! EnterNormalMode()
      if &buftype == 'terminal' && mode('') == 't'
          call feedkeys("\<c-w>N")
          call feedkeys("\<c-y>")
          map <buffer> <silent> <RightMouse> :call ExitNormalMode()<CR>
      endif
  endfunction

  " scrolling within terminal window
  tmap <silent> <ScrollWheelUp> <c-w>:call EnterNormalMode()<CR>
endif

