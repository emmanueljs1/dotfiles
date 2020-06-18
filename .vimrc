" Vundle Configuration "

set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')
" let Vundle manage Vundle, required
Plug 'VundleVim/Vundle.vim'
Plug 'scrooloose/nerdtree' " project explorer
Plug 'Xuyuanp/nerdtree-git-plugin' " project explorer git info
Plug 'scrooloose/nerdcommenter' " autocommenting
Plug 'vim-airline/vim-airline' " status bar
Plug 'vim-airline/vim-airline-themes' " theme
Plug 'tpope/vim-fugitive' " git info
Plug 'dense-analysis/ale' " syntax checker
Plug 'joshdick/onedark.vim' " theme
Plug 'sheerun/vim-polyglot' " advanced syntax highlighting
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'derekwyatt/vim-scala'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
call plug#end()

" use true colors for onedark theme
if has('macunix')
    if $TERM_PROGRAM == 'iTerm.app'
        if (has("termguicolors"))
           set termguicolors
       endif
    endif
else
    if (has("termguicolors"))
       set termguicolors
   endif
endif

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let NERDTreeShowHidden=1

let g:ale_set_balloons = 1
let g:ale_set_loclist = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
let g:airline#extensions#ale#enabled = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "M",
    \ "Staged"    : "A",
    \ "Untracked" : "N",
    \ "Renamed"   : "R",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "D",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" add nerdtree explorer automatically (optional, uncomment below)
" autocmd VimEnter * NERDTree .
" autocmd VimEnter * wincmd w

let g:merlin_disable_default_keybindings=1

let g:tagbar_type_rust = {
\ 'ctagstype' : 'rust',
\ 'kinds' : [
    \'T:types,type definitions',
    \'f:functions,function definitions',
    \'g:enum,enumeration names',
    \'s:structure names',
    \'m:modules,module names',
    \'c:consts,static constants',
    \'t:traits',
    \'i:impls,trait implementations',
\]
\}

" Vim Options "

" use vertical bar in iterm/terminal
if $TERM_PROGRAM == 'Apple_Terminal'
   let &t_SI.="\e[5 q"
   let &t_SR.="\e[4 q"
   let &t_EI.="\e[1 q"
elseif $TERM_PROGRAM == 'iTerm.app'
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

syntax on

silent! colorscheme onedark

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set number
set backspace=indent,eol,start
set mouse=a
set backup
set backupdir=~/.backup
set directory=~/.vimswap
set splitright
set splitbelow
set clipboard=unnamed
set sidescroll=1
set nowrap
set ignorecase
set timeoutlen=1000 ttimeoutlen=0
set eol

filetype plugin indent on

function! SwitchToFunctionalMode()
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
endfunction

function! SetupModifiableBuffer()
    if &modifiable
        if &ft ==# 'ocaml' || &ft ==# 'haskell'
            call SwitchToFunctionalMode()
            setlocal colorcolumn=81
        else
            setlocal colorcolumn=101
        endif
    endif
endfunction

" set up modifiable buffers
autocmd BufEnter * call SetupModifiableBuffer()

au BufRead,BufNewFile *.sbt set filetype=scala

" Key Mappings "

" Space in visual mode moves selected line(s) by one space
vnoremap <Space> :s/^/ /<CR>
vnoremap <Backspace> :s/^.//<CR>

" Ctrl+c to comment visual selection
vnoremap <C-c> :call NERDComment(1, 'toggle')<CR>

" d/D does not take contents into register (use x instead)
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D

" Ctrl+p opens up project view
silent! noremap <C-p> :NERDTreeToggle<CR>

" Ctrl+Shift+P opens up tag sidebar view
silent! noremap <S-p> :TagbarToggle<CR>

" Alt+j/k to switch between errors
if has('macunix')
    nmap <silent> ∆ <Plug>(ale_previous_wrap)
    nmap <silent> ˚ <Plug>(ale_next_wrap)
else
    nmap <silent> <A-j> <Plug>(ale_previous_wrap)
    nmap <silent> <A-k> <Plug>(ale_next_wrap)
endif

" Tab in normal mode opens up new tab
nnoremap <Tab> :tabnew<CR>

nnoremap ~ :vert term<CR>

" don't need to press shift+;
nnoremap ; :

" Tab/Shift-Tab in visual mode for indents
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

"Ctrl+j/k to move text up/down
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

" bind K to grep word under cursor
nnoremap K <Esc>:Ag <C-R><C-W><CR>

" bind t to :Files
nnoremap t <Esc>:Files<CR>

" bind m to :NERDTreeFind
nnoremap m <Esc>:NERDTreeFind<CR>

" Ag shows preview (need `bat` for syntax highlighting)
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview('right:50%'))

" Files shows preview (need `bat` for syntax highlighting)
command! -bang -nargs=* Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%'))

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
  tmap <C-n> <c-w>N
endif

