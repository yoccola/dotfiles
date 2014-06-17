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

### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
#bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }


# ------------------------------
# Look And Feel Settings
# ------------------------------
# プロンプトに色を付ける
autoload -U colors; colors
autoload colors; colors;

# LSCOLORS/LS_COLORS
LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32";
LSCOLORS="fxGxFxDxCxDxDxhbhdacEc";

# Do we need Linux or BSD Style?
if ls --color -d . &>/dev/null 2>&1
then
  # Linux Style
  export LS_COLORS=$LS_COLORS
  alias ls='ls --color=tty'
else
  # BSD Style
  export LSCOLORS=$LSCOLORS
  alias ls='ls -G'
fi

# Use same colors for autocompletion
zmodload -a colors
zmodload -a autocomplete
zmodload -a complist
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true

### Prompt ###
## 一般ユーザ時
##tmp_prompt="%{${fg[yellow]}%}%n%# %{${reset_color}%}"
#tmp_prompt="%{${fg[yellow]}%}%D{%T} %# %{${reset_color}%}"
#tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
#tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
#tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"
#
## rootユーザ時(太字にし、アンダーバーをつける)
#if [ ${UID} -eq 0 ]; then
#  tmp_prompt="%B%U${tmp_prompt}%u%b"
#  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
#  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
#  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
#fi
#
#PROMPT=$tmp_prompt    # 通常のプロンプト
#PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
#RPROMPT=$tmp_rprompt  # 右側のプロンプト
#SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
## SSHログイン時のプロンプト
#[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
#  PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
#;

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

### Command PATH
PATH=/usr/local/bin:/bin:~/.homesick/repos/dotfiles/home/bin:$PATH

### Gem
GEM_BIN=$(ruby -e 'require "rubygems"; puts Gem::bindir')
PATH=$GEM_BIN:$PATH


### Macports ###
case "${OSTYPE}" in
  darwin*)
  # for mac
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:/opt/local/man:$MANPATH
    # Homebrew
    PATH="$(brew --prefix)/bin:$PATH"
    # Homebrew Cask
    export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/usr/local/Caskroom"
    # Python
    export PATH=$PATH:/usr/local/share/python
  ;;
esac

# Editor
SVN_EDITOR='vim'
EDITOR='vim'
export SVN_EDITOR
export EDITOR

# history
export HISTSIZE=5000
export HISTCONTROL=ignoredups #ignoredups,ignorespace,erasedups
export HISTIGNORE=history:which   #you can use wild cart(*,?)

# cdコマンド実行後、lsを実行する
function cd() {
  builtin cd $@ && ls -lat;
}

#function history-all {
function hall() {
  history -E 1
}

export PATH

# 環境依存設定ファイル読み込み
[ -f ~/.zshrc.git-flow-completion ] && source ~/.zshrc.git-flow-completion

# for tmux
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

