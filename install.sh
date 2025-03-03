dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_backup          # old dotfiles backup directory
files="vimrc zshrc"               # list of files/folders in homedir

if [ -d $dir ]; then
    echo "dotfiles directory found, starting installation"
else
    echo "dotfiles directory not found (must be in root directory)"
    exit 1
fi
# create olddir
mkdir -p $olddir

# make backups
for file in $files; do
    mv ~/.$file $olddir
done

# vim specific setup
mv ~/.vim $olddir/.vim
mkdir -p ~/.backup
mkdir -p ~/.vimswap
scp -r $dir/.vimrc ~/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install and configure vim plugins
vim +PlugInstall

# install oh-my-zsh
CURR_PWD=$(pwd)

cd ~

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cd ~/.oh-my-zsh
OH_MY_ZSH_PWD=$(pwd)

# zsh setup
cat $dir/.zshrc >> ~/.zshrc

# starship setup
curl -sS https://starship.rs/install.sh | sh

mkdir -p ~/.config
cat $dir/starship.toml >> ~/.config/starship.toml

# for any extra machine-specific stuff
echo '"do-not-include' >> ~/.vimrc
echo "#do-not-include" >> ~/.zshrc

cd $CURR_PWD

echo "dotfiles installed successfully"
