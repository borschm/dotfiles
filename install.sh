#!/bin/bash

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
if [ $OS == "fedora" ]; then

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
        dnf install "$1" -y
    }

elif [$OS == "ubuntu" ]; then

    echo "Detected ubuntu, use apt-get to install packages"

    apt-get update

    install_package() {
        # echo "Try to install $1 ..."
        # if command_exists "$1"; then
        #     echo "    ... exists, DONE."
        # else
        #     apt-get -y install "$1"
        #     echo "    ... INSTALLED."
        # fi
        echo "Try to install $1:"
        apt-get -y install "$1"
    }

fi




# VIM
install_package vim

# tmux
install_package tmux

# powerline
if [ $OS == "fedora" ]; then
    install_package powerline 
    install_package powerline-fonts
else [ $OS == "ubuntu" ]; then
    install_package powerline
fi

# xclip
install_package xclip