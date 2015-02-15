#!/bin/zsh

# Create symbolic link in parent directory to file relative to current.
function link {
    SRC=`pwd`/$1
    DEST=../.$1
    if [[ ! -a $DEST ]];
    then
        ln -s $SRC $DEST
    fi
}

CONFIG_FILES=(
    'tmux.conf'
    'vimrc'
    'zshrc'
)

for FILE in $CONFIG_FILES;
do
    link $FILE;
done

