#!/bin/zsh

function link {
    SRC=`pwd`/$1
    DEST=../.$1
    if [[ ! -a $DEST ]];
    then
        ln -s $SRC $DEST
    fi
}

link tmux.conf
link vimrc
link zshrc

# ln -s `pwd`/tmux.conf ../.tmux.conf
# ln -s `pwd`/vimrc ../.vimrc
# ln -s `pwd`/zshrc ../.zshrc
