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
Plugin 'scrooloose/nerdtree' " project explorer
Plugin 'Xuyuanp/nerdtree-git-plugin' " project explorer git info
Plugin 'scrooloose/nerdcommenter' " autocommenting
Plugin 'vim-airline/vim-airline' " status bar
Plugin 'vim-airline/vim-airline-themes' " theme
Plugin 'tpope/vim-fugitive' " git info
Plugin 'vim-syntastic/syntastic' " syntax checker
Plugin 'Valloric/YouCompleteMe' " autocompletion
Plugin 'rust-lang/rust.vim' " rust support
Plugin 'beyondmarc/glsl.vim' " glsl support
Plugin 'joshdick/onedark.vim' " theme
Plugin 'sheerun/vim-polyglot' " advanced syntax highlighting
call vundle#end()            " required

" Vundle Plugin Options "

" let iterm use true colors for onedark theme
if $TERM_PROGRAM == 'iTerm.app'
    if (has("termguicolors"))
       set termguicolors
     endif
endif

let NERDTreeShowHidden=1

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_w = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_balloons = 1

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
set timeoutlen=1000 ttimeoutlen=0

filetype plugin indent on

function! AddColumnLimit()
    if &modifiable
        setlocal colorcolumn=101
    endif
endfunction

" add a column limit to modifiable buffers
autocmd BufEnter * call AddColumnLimit()

function! SwitchToFunctionalMode()
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
    setlocal colorcolumn=81
endfunction

" switch to functional mode for ocaml/haskell/scala files
autocmd FileType ocaml,haskell,scala call SwitchToFunctionalMode()

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

" Tab in normal mode opens up terminal window
nnoremap <Tab> :vert term<CR>

" Tab/Shift-Tab in insert/visual mode for indents 
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

