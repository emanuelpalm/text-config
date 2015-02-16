#!/usr/bin/env bash

# Installs packages for OS $1 and configurations fom GIT repository $2.
function main {
    install_os_packages "$1"
    install_packages
    install_configurations_from "$2"
    configure_packages

    report "Done."
}

# Executes setup for OS of type $1, if supported.
function install_os_packages {
    case "$1" in
        "darwin")
            # TODO
            ;;
        "linux-gnu")
            report "Updating package library ..."
            apt-get update > /dev/null
            report "Installing packages ..."
            apt-get install -y git vim tmux zsh > /dev/null
            ;;
        *)
            panic "The platform \"$1\" is not supported."
            ;;
    esac
}

# Reports message $1.
function report {
    echo -e "\e[34m>\e[0m $1"
}

# Panics with message $1, terminating script.
function panic {
    echo -e "\e[31m!!\e[0m $1"
    exit 1
}

# Installs various plaform-independent packages.
function install_packages {
    clone_repo_to "https://github.com/gmarik/Vundle.vim.git"      "$HOME/.vim/bundle/Vundle.vim"
    clone_repo_to "https://github.com/robbyrussell/oh-my-zsh.git" "$HOME/.oh-my-zsh"
    clone_repo_to "https://github.com/powerline/fonts.git"        "$HOME/.powerline-fonts"
}

# Clones repository at $1 to local folder $2.
function clone_repo_to {
    which git > /dev/null
    if [[ $? != "0" ]];
    then
        panic "Git not installed."
    fi
    if [[ ! -a $2 ]];
    then
        git clone $1 $2
        if [[ $? != "0" ]];
        then
            panic "Failed to git clone \"$1\"."
        fi
    fi
}

# Installs configuration files from repository $1.
function install_configurations_from {
    TARGET_REPO_DIR="$HOME/.text-config"
    CONFIG_FILES=`find $TARGET_REPO_DIR -iname "*rc" && find $TARGET_REPO_DIR -iname "*.conf"`

    clone_repo_to "$1" "$TARGET_REPO_DIR"
    create_symbolic_links_to "$CONFIG_FILES" "$HOME"
}

# Creates symbolik links to given files $1 in directory $2.
function create_symbolic_links_to {
    for LINE in $1;
    do
        create_symbolic_link_to $LINE $2
    done
}

# Creates symbolik link for $1 at $2.
function create_symbolic_link_to {
    SOURCE=$1
    TARGET=$2/.`basename $1`
    if [[ ! -a $TARGET ]];
    then
        ln -s $SOURCE $TARGET
        if [[ $? == "0" ]];
        then
            report "Created link at \"$TARGET\"."
        else
            panic "Failed to create link at \"$TARGET\"."
        fi
    fi
}

# Configures installed packages. 
function configure_packages {
    # Vundle plugins.
    vim +PluginInstall +qall

    # Oh My Zsh.
    chsh -s `/usr/bin/env zsh`

    # Powerline fonts.
    cd "$HOME/.powerline-fonts" && ./install.sh

    which gconftool-2
    if [[ $? == "0" ]];
    then
        gconftool-2 --set /apps/gnome-terminal/profiles/Default/font --type string "Ubuntu Mono derivative Powerline 13"
    fi
}

SOURCE_REPO='https://github.com/emanuelpalm/text-config.git'
if [[ ! -z "$1" ]];
then
    SOURCE_REPO="$1"
fi

main "$OSTYPE" "$SOURCE_REPO"

