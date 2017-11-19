#!/bin/bash

# define distributions
ARCH="arch"
FEDORA="fedora"
UBUNTU="ubuntu"

# function to test if command exists
command_exists() {
    type "$1" > /dev/null 2>&1
}


echo "Install required packages for dotfiles."


# Get information about distribution:
if [ -f /etc/os-release ]; then
    # source os release information
    . /etc/os-release
    OS=$ID
else
    echo "Could not find OS release information. EXIT!"
    exit 1
fi


# define function to install packages with package manager
if [ $OS == $FEDORA ]; then

    echo "Detected fedora, use dnf to install packages"

    install_package() {
        # echo "Try to install $1 ..."
        # if command_exists "$1"; then
        #     echo "    ... exists, DONE."
        # else
        #     dnf install "$1" -y
        #     echo "    ... INSTALLED."
        # fi
        echo "Try to install $1:"
        sudo dnf install "$1" -y
    }

elif [ $OS == $UBUNTU ]; then

    echo "Detected ubuntu, use apt-get to install packages"

    sudo apt-get update

    install_package() {
        # echo "Try to install $1 ..."
        # if command_exists "$1"; then
        #     echo "    ... exists, DONE."
        # else
        #     apt-get -y install "$1"
        #     echo "    ... INSTALLED."
        # fi
        echo "Try to install $1:"
        sudo apt-get -y install "$1"
    }

elif [ $OS == $ARCH ]; then

    echo "Detected arch, use pacman to install packages"

    install_package() {
        echo "Try to install $1:"
        sudo pacman -S "$1" --noconfirm
    }

fi




# VIM
install_package vim

# tmux
if [ $OS == $UBUNTU ]; then
    # version in repo is quite old, build from source instead
    ./build_tmux.sh
else
    install_package tmux
fi

# hack font
if [ $OS == $UBUNTU ]; then
    install_package fonts-hack-ttf
elif [ $OS == $ARCH ]; then
    install_package ttf-hack
elif [ $OS == $FEDORA ]; then
    echo "Install hack font manually."
fi

# # powerline
# if [ $OS == $FEDORA ]; then
#     echo "something"
#     install_package powerline 
#     install_package powerline-fonts
# elif [ $OS == $UBUNTU ]; then
#     install_package powerline
# fi

# xclip
install_package xclip

# oh my zsh
install_package zsh
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Install oh-my-zsh, follow instructions on http://ohmyz.sh/"
fi
