dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_backup          # old dotfiles backup directory
files="vimrc bash_profile"        # dotfiles

for file in $files; do 
  sed '/.do-not-include/,$d' ~/.$file > $dir/.$file
done
