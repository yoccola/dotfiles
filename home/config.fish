# Path

# Variables
set -gx AWS_REGION "ap-northeast-1"

# aliases
alias date='gdate'

# peco
#set fish_plugins theme peco
#
#function fish_user_key_bindings
#  bind \cr peco_select_history # Bind for prco history to Ctrl+r
#end

function pet-select
  set -l query (commandline)
  pet search --query "$query" $argv | read cmd
  commandline $cmd
end

function fish_user_key_bindings
  #bind \cs 'pet-select --layout=bottom-up'
  bind \cs 'pet-select'
end

# pyenv
#status --is-interactive; and source (pyenv init -| psub)
#set -x PATH $HOME/.pyenv/shims $PATH
# THEME PURE #
set fish_function_path /Users/h-imai/.config/fish/functions/theme-pure $fish_function_path

# PlantUML
set -x PLANTUML_LIMIT_SIZE 8192
