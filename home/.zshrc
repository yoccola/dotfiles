#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
if [ -f ~/.zshrc_alias ]; then
  . ~/.zshrc_alias
fi

autoload -Uz ~/bin/*

# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vim        # エディタをvimに設定
export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
export AUTOFEATURE=true  # autotestでfeatureを動かす

#bindkey -e              # キーバインドをemacsモードに設定
bindkey -v               # キーバインドをviモードに設定

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する 
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

# すべてのヒストリを表示する
#function hall { history -E 1 }

# ------------------------------
# Look And Feel Settings
# ------------------------------
export CLICOLOR=true

### Title (user@hostname) ###
case "${TERM}" in
kterm*|xterm*|)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}\007"
  }
  ;;
esac

# ------------------------------
# Other Settings
# ------------------------------
### RVM ###
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

### Environment dependence settings ###
case "${OSTYPE}" in
  linux*)
    ### Command PATH
    PATH=~/bin:$PATH
  ;;
  darwin*)
  # for mac

    ### Command PATH
    PATH=/bin:~/.homesick/repos/dotfiles/home/bin:$PATH

    # Gem
    GEM_BIN=$(ruby -e 'require "rubygems"; puts Gem::bindir')
    PATH=$GEM_BIN:$PATH
    # Mac Ports
    PATH=/opt/local/bin:/opt/local/sbin:$PATH
    MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
    # Homebrew
    PATH="$(brew --prefix)/bin:$PATH"
    # Homebrew Cask
    export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"
    # Python
    PATH=$PATH:/usr/local/bin/python
    # Go
    GOPATH=$HOME/go
    # source
    source ~/.zsh.d/zsh-notify/notify.plugin.zsh
    # terminal-notifier
    export SYS_NOTIFIER="$(which terminal-notifier)"
    export NOTIFY_COMMAND_COMPLETE_TIMEOUT=10
  ;;
esac

# Editor
SVN_EDITOR='vim'
EDITOR='vim'
export SVN_EDITOR
export EDITOR

# cdコマンド実行後、lsを実行する
function cd() {
  builtin cd $@ && ls -lat;
}

export PATH
export MANPATH
export GOPATH

# 環境依存設定ファイル読み込み
[ -f ~/.zshrc.git-flow-completion ] && source ~/.zshrc.git-flow-completion

# for tmux
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'


# for peco
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-snippets() {
    BUFFER=$(grep -v "^#" ~/.snippets | peco --query "$LBUFFER")
    zle clear-screen
}
zle -N peco-snippets
bindkey '^s' peco-snippets


net_tools_deprecated_message () {
  echo -n 'net-tools コマンドはもう非推奨ですよ？おじさんなんじゃないですか？ '
}

arp () {
  net_tools_deprecated_message
  echo 'Use `ip n`'
}
ifconfig () {
  net_tools_deprecated_message
  echo 'Use `ip a`, `ip link`, `ip -s link`'
}
iptunnel () {
  net_tools_deprecated_message
  echo 'Use `ip tunnel`'
}
iwconfig () {
  echo -n 'iwconfig コマンドはもう非推奨ですよ？おじさんなんじゃないですか？ '
  echo 'Use `iw`'
}
nameif () {
  net_tools_deprecated_message
  echo 'Use `ip link`, `ifrename`'
}
netstat () {
  net_tools_deprecated_message
  echo 'Use `ss`, `ip route` (for netstat -r), `ip -s link` (for netstat -i), `ip maddr` (for netstat -g)'
}
route () {
  net_tools_deprecated_message
  echo 'Use `ip r`'
}

# import local settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
