# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

alias updatedb='/usr/libexec/locate.updatedb'
alias ll='ls -lat'
alias vi='vim'
alias view='vi -R'
alias drop='ssh drop'
alias apsvn='ssh apsvn'
alias stu='svn st -u'
alias sdi='svn di'
alias up='cd ..'
alias upp='cd ../..'
alias uppp='cd ../../..'
alias f='open -a Fraise' # エディタ：Fraiseで開く
alias psa='ps aux'
alias psag='ps aux | grep'
alias hi='history'

# Git
alias gb='git branch'

# Azure command-line tool
alias az='azure'
alias aza='azure account'

# other
date='gdate'

SVN_EDITOR='vi'
EDITOR='vi'
export SVN_EDITOR

export PATH=~/bin:/usr/local/bin:$PATH

# node
export PATH=$HOME/.nodebrew/current/bin:$PATH

# java
export JAVA_HOME=`/usr/libexec/java_home`
export PATH=$PATH:$JAVA_HOME/bin

# history
export HISTSIZE=3000

# environment setting
case "${OSTYPE}" in
  darwin*)
 # for mac
  # Homebrew
  export PATH="$(brew --prefix)/bin:$PATH"
  # Homebrew Cask
  export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"
  # Python
  export PATH=$PATH:/usr/local/share/python
  ;;
esac

# Local Settings
if [ -f ~/.bashrc_local ]; then
  . ~/.bashrc_local
fi
# enhancd
if [ -f "/Users/macbookair/.enhancd/bash/enhancd.bash" ]; then
    source "/Users/macbookair/.enhancd/bash/enhancd.bash"
fi

# PlantUML
export PLANTUML_LIMIT_SIZE=8192
. "$HOME/.cargo/env"
