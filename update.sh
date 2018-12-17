dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_backup          # old dotfiles backup directory
files="vimrc zshrc"               # dotfiles

for file in $files; do 
  sed '/.do-not-include/,$d' ~/.$file > $dir/.$file
done

if [ "$(uname)" == "Darwin" ]; then
    if [ -d /Applications/iTerm.app ]; then
        scp ~/Library/Preferences/com.googlecode.iterm2.plist $dir/com.googlecode.iterm2.plist
    fi
fi
