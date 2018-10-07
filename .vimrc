" Vundle Configuration "

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
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'dracula/vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rust-lang/rust.vim'
Plugin 'beyondmarc/glsl.vim'
call vundle#end()            " required

" Vundle Plugin Options "

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

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" add nerdtree explorer automatically (optional, uncomment below)
" autocmd VimEnter * NERDTree .
" autocmd VimEnter * wincmd w

" Vim Options "

try
    color dracula
catch /^Vim\%((\a\+)\)\=:E185/
    echo "Color scheme dracula not found (if first-time setup then you should continue with ENTER)"
endtry

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set colorcolumn=101
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
set columns=130
set lines=45

filetype plugin indent on
syntax on

" use mac terminal's cursor
if has('macunix')
  let &t_SI.="\e[5 q"
  let &t_SR.="\e[4 q"
  let &t_EI.="\e[1 q"
endif

" change column limit to 80 characters for ocaml/haskell files
autocmd FileType ocaml,haskell setlocal colorcolumn=81

autocmd FileType ocaml,haskell setlocal tabstop=2
autocmd FileType ocaml,haskell setlocal softtabstop=2
autocmd FileType ocaml,haskell setlocal shiftwidth=2

" Key Mappings "

" Space in visual mode moves selected line(s) by one space
vnoremap <Space> :s/^/ /<CR>
vnoremap <Backspace> :s/^.//<CR>

" Ctrl+c to comment visual selection
vnoremap <C-c> :call NERDComment(1, 'toggle')<CR>

" d does not take contents into register (use x instead)
nnoremap d "_d
vnoremap d "_d

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
inoremap <S-Right> <ESC>zl
inoremap <S-Left> <ESC>zh

" vertical split with Ctrl+n
inoremap <C-n> <ESC>:vsp<CR>==gi
noremap <C-n> :vsp<CR>

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

