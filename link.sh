#!/bin/bash

# script to link all dotfiles into home directory

DOTFILES=$HOME/dotfiles

# find all files that will eventually be linked
linkables=$( find -H "$DOTFILES" -name '*.symlink' )

# link files to home folder
for file in $linkables; do
    # filename how it appears in home folder
    filename=".$( basename $file '.symlink' )"
    # file with path to backup
    target="$HOME/$filename"

    if [ -e $target ]; then
        echo "~${target#$HOME} already exists... Replacing."
        ln -sf $file $target
    else
        echo "Creating symlink for $file"
        ln -s $file $target
    fi
done

# set up vundle if not already there
VUNDLE_DIR=$HOME/.vim/bundle/Vundle.vim
if [ ! -d $VUNDLE_DIR ]; then
    mkdir -p $VUNDLE_DIR
    git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE_DIR
fi

# create folder for vim tmp files
if [ ! -d $HOME/.vim-tmp ]; then
    mkdir -p $HOME/.vim-tmp
fi
