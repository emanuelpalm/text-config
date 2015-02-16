export ZSH=~/.oh-my-zsh

ZSH_THEME="agnoster"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git)

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin"
source $ZSH/oh-my-zsh.sh

if [[ `uname` == "Darwin" ]];
then
    which mvim
    if [[ $? == "0" ]];
    then
        alias vim="mvim -v"
    fi
fi

