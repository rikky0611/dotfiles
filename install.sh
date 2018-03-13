#!/bin/bash
DOT_FILES=(.bashrc .bash_profile .zshrc .zprofile .vim .vimrc)

# symbolic link
for file in ${DOT_FILES[@]}
do
    ln -fs $HOME/dotfiles/$file $HOME/$file
done

