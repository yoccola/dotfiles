#!/bin/bash

ln -fs dotfiles/home/.* ~/

cd ~/.homesick/repos/dotfiles/home/.zprezto
git submodule update --init --recursive
