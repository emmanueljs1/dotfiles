dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_backup          # old dotfiles backup directory
files="vimrc zshrc"        # list of files/folders in homedir

if test -d dir; then 
    echo "dotfiles directory found, starting installation"
else
    echo "dotfiles directory not found (must be in root directory)"
fi

# create olddir
mkdir -p $olddir

# vim specific setup
mv ~/.vim $olddir/.vim
mkdir -p ~/.backup
mkdir -p ~/.vimswap
mkdir -p ~/.vim/bundle 
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# make backups
for file in $files; do
    mv ~/.$file $olddir
    scp -r $dir/.$file ~/.$file
done

# install and configure vim plugins
vim +PluginInstall +qall

cd ~/.vim/bundle/YouCompleteMe

options="--clang-completer"

./install.py $options

source .zshrc
zsh
echo "dotfiles installed successfully"
