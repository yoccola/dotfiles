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

SVN_EDITOR='vi'
EDITOR='vi'
export SVN_EDITOR

export PATH=~/bin:/usr/local/bin:$PATH

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
  ;;
esac
