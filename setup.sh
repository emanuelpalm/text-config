#!/usr/bin/env zsh

DOWNLOAD_DIR="downloads/"
CONFIG_FILES=`find -iname '*rc' && find -iname '*.conf'`

# Main function. Executed at bottom of file.
function main {
    ensure_dir      $DOWNLOAD_DIR
    setup_ostype    $OSTYPE
    create_links_to $CONFIG_FILES ../

    #download "http://static.thegeekstuff.com/wp-content/themes/thesis_18/custom/images/thegeekstuff.gif" $DOWNLOAD_DIR
}

# Ensures directory $1 exists.
function ensure_dir {
    mkdir -p $1
    if [[ $? != "0" ]];
    then
        panic "Failed to ensure directory \"$1\". exists"
    fi
}

# Panics with message $1, terminating script.
function panic {
    echo -e "\e[31m!!\e[0m $1"
    exit 1
}

# Executes setup for OS type $1, if supported.
function setup_ostype {
    case "$1" in
        "darwin")
            # TODO
            ;;
        "linux-gnu")
            # TODO
            ;;
        *)
            panic "The OS type \"$1\" is not supported."
            ;;
    esac
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
        echo "> '$TARGET' already downloaded."
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

main

