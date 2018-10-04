dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_backup          # old dotfiles backup directory
files="vimrc bash_profile"    # list of files/folders in homedir

# create olddir
mkdir -p $olddir

for file in $files; do
    mv ~/.$file $olddir 
    scp -r $dir/.$file ~/.$file
done

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qall

cd ~/.vim/bundle/YouCompleteMe

options="--clang-completer"

./install.py $options

cd
