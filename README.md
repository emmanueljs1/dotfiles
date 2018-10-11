<h1>emma's dotfiles</h1>

<h2>Installing:</h2>

Clone this repo <em>into your root dir</em>, then running:

```
./install.sh
``` 

should do everything

<h2>Updating dotfiles:</h2>

If you make an update to a dotfile and want to update your own clone of this repo you can run:

```
./update.sh
``` 

This ignores anything after "do-not-include" in your dotfiles (for machine specific things).
For example, if you have `#do-not-include` in .bash_profile or `"do-not-include`
in .vimrc then everything after will not be included

<h2>Notes:</h2>

- For syntastic to work with nerdtree-git-plugin add `nested` right before `call` in the `nerdtreegitplugin` augroup definition in ~/.vim/nerdtree-git-plugin/nerdtree_plugin/git_status.vim (only after running `./install.sh`)
- If you have merlin installed (`opam install merlin`), running `opam user-setup install` should configure Vim to use merlin
- YouCompleteMe provides autocompletion for other things, you can re-install it with more options if you want (instructions [here](https://valloric.github.io/YouCompleteMe/))

<h2>Dependencies:</h2>

- Some things that are probably already installed (vim, git, clang, python)
    - For terminal inside vim functionality, you need vim 8.1
- Some plugin dependencies (you can remove the relevant plugin for each of these instead of getting the dependency)
    - [ctags](https://github.com/universal-ctags/ctags) for the [tagbar](https://github.com/majutsushi/tagbar) plugin, which lets you view the current file more concisely
    - [fzf](https://github.com/junegunn/fzf) for the [fzf-vim](https://github.com/junegunn/fzf.vim) plugin, super useful plugin that lets you search within your project
    - [Powerline fonts](https://github.com/powerline/fonts) (has an easy install script as well) and then set your terminal font to a Powerline font for 
      the [airline](https://github.com/vim-airline/vim-airline) status bar to display properly. Alternatively, you can change the line 
      `let g:airline_powerline_fonts=1` to `let g:airline_powerline_fonts=0` in `~/.vimrc`
    - [iTerm2](https://www.iterm2.com/) (with Preferences -> Terminal -> 'Save lines to scrollback in alternate screen mode' unchecked)
      for the [onedark.vim](https://github.com/joshdick/onedark.vim) color scheme to look better
