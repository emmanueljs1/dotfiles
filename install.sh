dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_backup          # old dotfiles backup directory
files="vimrc bash_profile"        # list of files/folders in homedir

# create olddir
mkdir -p $olddir

# vim specific setup
mv ~/.vim $olddir/.vim
mkdir -p ~/.backup
mkdir -p ~/.vimswap
mkdir -p ~/.vim/bundle 
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

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

# return to root
cd
