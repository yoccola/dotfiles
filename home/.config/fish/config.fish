# PATH
if status --is-login
    set -x PATH $PATH ~/bin
end

# Variables
## AWS
if test -x /usr/local/bin/aws
  set -gx AWS_REGION (aws configure get region)
  set -gx AWS_ACCESS_KEY_ID (aws configure get aws_access_key_id)
  set -gx AWS_SECRET_ACCESS_KEY (aws configure get aws_secret_access_key)
end


# aliases
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
set fish_function_path ~/.config/fish/functions/theme-pure $fish_function_path

# Java
set -x JAVA_HOME (/usr/libexec/java_home)

# PlantUML
set -x PLANTUML_LIMIT_SIZE 8192

# Android SDK
set -x PATH ~/Library/Android/sdk/platform-tools $PATH

# rbenv
set -x PATH $HOME/.rbenv/bin $PATH
status --is-interactive; and source (rbenv init -|psub)
