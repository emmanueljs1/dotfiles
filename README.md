<h1>emma's dotfiles</h1>

<h2>Installing:</h2>

Clone this repo, then running:

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

- Some things that are probably already installed (git, clang, python)
- One of the Vundle plugins is Rust dependent (rust.vim)
