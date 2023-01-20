call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree' " project explorer
Plug 'Xuyuanp/nerdtree-git-plugin' " project explorer git info
Plug 'scrooloose/nerdcommenter' " autocommenting
Plug 'vim-airline/vim-airline' " status bar
Plug 'vim-airline/vim-airline-themes' " theme
Plug 'tpope/vim-fugitive' " git info
Plug 'arcticicestudio/nord-vim' " theme
Plug 'joshdick/onedark.vim' " theme
Plug 'sainnhe/everforest' "theme
Plug 'NLKNguyen/papercolor-theme' "theme
Plug 'pineapplegiant/spaceduck', {'branch': 'main'} "theme
Plug 'sheerun/vim-polyglot' " advanced syntax highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'derekwyatt/vim-scala'
Plug '/usr/homebrew/bin/fzf'
Plug 'neovimhaskell/haskell-vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'whonore/Coqtail'
Plug 'emmanueljs1/ott-vim'
Plug 'emmanueljs1/coq-vim-conceal', {'branch': 'main'}
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

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

let g:NERDTreeGitStatusIndicatorMapCustom = {
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

augroup CoqtailHighlights
  autocmd!
  autocmd ColorScheme *
    \  hi def CoqtailChecked ctermbg=DarkBlue
    \| hi def CoqtailSent    ctermbg=DarkBlue
augroup END

syntax on

silent! colorscheme spaceduck

set background=dark
set encoding=utf-8
set expandtab
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
set hlsearch

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
            set tabstop=4
            set softtabstop=4
            set shiftwidth=4
            setlocal colorcolumn=101
        endif
    endif
endfunction

" set up modifiable buffers
augroup custom
    autocmd BufEnter * call SetupModifiableBuffer()
    autocmd BufEnter *.ott set filetype=ott
    autocmd BufEnter *.mng set filetype=tex
augroup end

" Key Mappings "

" Space in visual mode moves selected line(s) by one space
vnoremap <Space> :s/^/ /<CR>
vnoremap <Backspace> :s/^.//<CR>

" Ctrl+c to comment visual selection
vnoremap <C-c> :call nerdcommenter#Comment(1, 'toggle')<CR>

" d/D does not take contents into register (use x instead)
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D

" Ctrl+p opens up project view
silent! noremap <C-p> :NERDTreeToggle<CR>

" Ctrl+Shift+P opens up tag sidebar view
silent! noremap <S-p> :TagbarToggle<CR>

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

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  endif
endfunction

" bind t to :Files
nnoremap t <Esc>:Files<CR>

" bind m to :NERDTreeFind
nnoremap m <Esc>:NERDTreeFind<CR>

" double esc unhighlights search results
nnoremap <esc><esc> :noh<return>

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

" coc.nvim configuration
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nnoremap <silent><leader>b <Plug>(coc-diagnostic-prev)
nnoremap <silent><leader>n <Plug>(coc-diagnostic-next)
nnoremap <silent><leader>f  <Plug>(coc-fix-current)
