#!/bin/bash

# backup dotfiles that will be replaced by symlinks to the dotfiles folder

# define paths to dotfile folter and backup folder
DOTFILES=$HOME/dotfiles
BACKUP_DIR=$HOME/dotfiles-backup

echo "Creating backup directory at $BACKUP_DIR"
if [ ! -d $BACKUP_DIR ]; then
    mkdir -p $BACKUP_DIR
fi

# find all files that will eventually be linked
linkables=$( find -H "$DOTFILES" -name '*.symlink' )

# copy files to backup folder if possible/necessary
for file in $linkables; do
    # filename how it appears in home folder
    filename=".$( basename $file '.symlink' )"
    # file with path to backup
    target="$HOME/$filename"
    if [[ -f $target && ! -L $target ]]; then
        echo "backing up $filename"
        cp $target $BACKUP_DIR
    else
        echo -e "$filename does not exist at this location or is a symlink"
    fi
done
