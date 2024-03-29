<h1>emma's dotfiles</h1>

<h2>Installing:</h2>

Clone this repo <em>into your root dir</em>, then running:

```
./install.sh
``` 

should do everything to have your terminal / vim up and running.

Can append contents of `.gitconfig` to your own root `.gitconfig`.

<h2>Updating dotfiles:</h2>

If you make an update to a dotfile and want to update your own clone of this repo you can run:

```
./update.sh
``` 

This ignores anything after "do-not-include" in your dotfiles (for machine specific things).
For example, if you have `#do-not-include` in .bash_profile or `"do-not-include`
in .vimrc then everything after will not be included

<h2>Notes:</h2>

- If you have merlin installed (`opam install merlin`), running `opam user-setup install` should configure Vim to use merlin

- Configure coc.nvim language servers (e.g. for [Haskell](https://github.com/neoclide/coc.nvim/wiki/Language-servers#haskell) and [OCaml](https://github.com/neoclide/coc.nvim/wiki/Language-servers#ocaml-and-reasonml))

<h2>Dependencies:</h2>

- [yarn](https://classic.yarnpkg.com/en/) for [coc.nvim](https://github.com/neoclide/coc.nvim)
    - If this dependency is missed, `:PlugInstall` will not suffice -- go into `~/.vim/plugged/coc.nvim` and run `yarn install` 
- zsh (4.9 or greater) for [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- Some things that are hopefully already installed: vim, git, clang, cmake, python2.7, curl/wget
    - For terminal inside vim functionality, you need vim 8
- Some plugin dependencies (you can remove the relevant plugin for each of these instead of getting the dependency)
    - [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts#patched-fonts) and then set your terminal font to an installed Nerd Font for 
      the [airline](https://github.com/vim-airline/vim-airline) status bar to display properly. Alternatively, you can change the line 
      `let g:airline_powerline_fonts=1` to `let g:airline_powerline_fonts=0` in `~/.vimrc`
    - [fzf](https://github.com/junegunn/fzf) for the [fzf-vim](https://github.com/junegunn/fzf.vim) plugin, super useful plugin that lets you search within your project
    - [ag](https://github.com/ggreer/the_silver_searcher) for fzf-vim's project search feature + for grepping
    - [bat](https://github.com/sharkdp/bat) for fzf-vim's project search feature to syntax highlight file previews (**optional**)
    - [fd](https://github.com/sharkdp/fd) for fzf-vim's file searching
    - [iTerm2](https://www.iterm2.com/) (with Preferences -> Terminal -> 'Save lines to scrollback in alternate screen mode' unchecked)
      for the [onedark.vim](https://github.com/joshdick/onedark.vim) color scheme to look better
