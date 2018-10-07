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

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

let g:onedark_termcolors=256

let NERDTreeShowHidden=1

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'

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

syntax on

try
    colorscheme onedark
catch /^Vim\%((\a\+)\)\=:E185/
    echo "Color scheme not found (if first-time setup then you should continue with ENTER)"
endtry

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set colorcolumn=101
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
set columns=130
set lines=45
set timeoutlen=1000 ttimeoutlen=0

filetype plugin indent on

" use different cursor
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

