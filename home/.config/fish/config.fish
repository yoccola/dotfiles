<<<<<<< HEAD:home/config.fish
# PATH
if status --is-login
    set -x PATH $PATH ~/bin
end

# rbenv
set -x PATH $HOME/.rbenv/bin $PATH
status --is-interactive; and source (rbenv init -|psub)
=======
# Path to Oh My Fish install.
set -gx OMF_PATH "/Users/hi/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/Users/h-imai/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish
>>>>>>> b695d1224f0aec2fae472682ef916e152dfad091:home/.config/fish/config.fish

# Variables
set -gx AWS_REGION "ap-northeast-1"

# aliases
alias date='gdate'
alias dc='docker-compose'


# peco
function peco_select_history_order
  if test (count $argv) = 0
    set peco_flags --layout=top-down
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end

  history|peco $peco_flags|read foo

  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

# pet
function pet-select
  set -l query (commandline)
  pet search --query "$query" $argv | read cmd
  commandline $cmd
end

function fish_user_key_bindings
  bind \cr 'peco_select_history_order' # Ctrl + R
  bind \cs 'pet-select --layout=bottom-up'
end

# pyenv
#status --is-interactive; and source (pyenv init -| psub)
#set -x PATH $HOME/.pyenv/shims $PATH
# THEME PURE #
set fish_function_path /Users/h-imai/.config/fish/functions/theme-pure $fish_function_path

# Java
set -x JAVA_HOME (/usr/libexec/java_home)

# PlantUML
set -x PLANTUML_LIMIT_SIZE 8192

# Android SDK
set -x PATH /Users/hi/Library/Android/sdk/platform-tools $PATH

# rbenv
status --is-interactive; and source (rbenv init -|psub)
