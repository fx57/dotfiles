#!/bin/bash

pushd $HOME/dot
cp -f gitconfig $HOME/.gitconfig
ln -fs dot/bashrc $HOME/.bashrc
ln -fs dot/vimrc $HOME/.vimrc
ln -fs dot/vim $HOME/.vim
bin/apt-cyg install vim
popd
source $HOME/.bashrc

