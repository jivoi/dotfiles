#!/bin/bash

# Installs dotfiles

realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

safe_link(){
    local src="$1"
    local dest="$HOME/`basename $src`"
    [ ! -e "$dest" ] && ln -sf "$src" "$dest"
}

# Get root
SCRIPT_PATH=`realpath $0`
DOTFILES=`dirname $SCRIPT_PATH`
EXCLUDE="sh_config\|README\|bootstrap.sh"

# Install dir symlinks 
safe_link "$DOTFILES/bin"
safe_link "$DOTFILES/.msf4"
# Install dotfiles symlinks
for f in `ls -la $DOTFILES|grep "^-"|awk '{print $NF}'|grep -v $EXCLUDE`; do
    safe_link "$DOTFILES/$f"
done
