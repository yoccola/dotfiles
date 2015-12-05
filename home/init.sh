#!/bin/bash

cd ~/.homesick/repos/dotfiles/home/.zprezto
git submodule update --init --recursive

ln -fs dotfiles/home/.* ~/

