#!/bin/bash
for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    ln -fs $HOME/dotfiles/$f $HOME/$f
done
echo "finish install.sh" 
