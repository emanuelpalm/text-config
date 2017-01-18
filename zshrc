export ZSH=~/.oh-my-zsh

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
ZSH_THEME="agnoster"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

if [[ `uname` == "Darwin" ]];
then
    which mvim > /dev/null
    if [[ $? == "0" ]];
    then
        alias vim="mvim -v"
    fi
    export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin"
fi

alias tmux="tmux -2"

unsetopt autocd
bindkey -v
zstyle :compinstall filename '/home/emanuel/.zshrc'
autoload -Uz compinit
compinit
