#!/usr/bin/env bash

# Default repository.
SOURCE_REPO='git@github.com:emanuelpalm/text-config.git'
if [[ ! -z "$1" ]];
then
    SOURCE_REPO=$1
fi

# Main function. Executed at bottom of file.
function main {
    # Download packages and install platform-specific utilities.
    setup_plaform   $OSTYPE

    SOURCE_REPO=$1
    TARGET_REPO_DIR='~/.text-config'
    clone_repo_to   $SOURCE_REPO $TARGET_REPO_DIR

    # Prepare directories.
    DOWNLOAD_DIR="$TARGET_REPO_DIR/downloads/"
    ensure_dir      $TARGET_REPO_DIR
    ensure_dir      $DOWNLOAD_DIR

    # Create symbolic links to various configuration files.
    CONFIG_FILES=`find -iname "$TARGET_REPO_DIR/*rc" && find -iname "$TARGET_REPO_DIR/*.conf"`
    create_links_to $CONFIG_FILES $TARGET_REPO_DIR

    #download "http://static.thegeekstuff.com/wp-content/themes/thesis_18/custom/images/thegeekstuff.gif" $DOWNLOAD_DIR
}

# Executes setup for OS type $1, if supported.
function setup_plaform {
    case "$1" in
        "darwin")
            # TODO
            ;;
        "linux-gnu")
            apt-get update
            apt-get install git vim
            ;;
        *)
            panic "The platform \"$1\" is not supported."
            ;;
    esac
}

# Panics with message $1, terminating script.
function panic {
    echo -e "\e[31m!!\e[0m $1"
    exit 1
}

# Clones repository at $1 to local folder $2.
function clone_repo_to {
    which git
    if [[ $? != "0" ]];
    then
        panic "Git not installed."
    fi
    git clone $1 $2
}

# Ensures directory $1 exists.
function ensure_dir {
    mkdir -p $1
    if [[ $? != "0" ]];
    then
        panic "Failed to ensure directory \"$1\". exists"
    fi
}

# Creates symbolik links to given files $1 in directory $2.
function create_links_to {
    echo $1 | while read LINE;
    do
        create_link_to $LINE $2
    done
}

# Creates symbolik link for $1 at $2.
function create_link_to {
    LINK=`basename $1`
    SOURCE=`pwd`/$LINK
    TARGET=$2.$LINK
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

# Reports message $1.
function report {
    echo -e "\e[34m>\e[0m $1"
}

# Downloads file at $1 into folder $2.
function download {
    SOURCE=$1
    TARGET=$2`basename $1`
    if [[ -e $TARGET ]];
    then
        report "\"$TARGET\" already downloaded."
        return
    fi
    curl -I $SOURCE > /dev/null 2&> /dev/null
    if [[ $? == "0" ]];
    then
        report "Downloading to $TARGET ..."
        curl -O $SOURCE > /dev/null
    else
        panic "Failed to download $TARGET."
    fi
}

main $SOURCE_REPO

