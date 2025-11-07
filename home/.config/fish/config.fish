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
alias dc='docker compose'

# Starship
starship init fish | source

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

# google cloud
function gce-ssh
  set -l select (gcloud compute instances list --filter="STATUS:RUNNING" | /usr/local/bin/peco | awk '{print $1,$2}')
  set -l host (echo $select | awk '{print $1}')
  set -l zone (echo $select | awk '{print $2}')
  gcloud compute ssh $host --internal-ip --zone $zone
end

# pyenv
#status --is-interactive; and source (pyenv init -| psub)
#set -x PATH $HOME/.pyenv/shims $PATH
# Java
set -x JAVA_HOME (/usr/libexec/java_home)

# Rust
source ~/.cargo/env.fish

# PlantUML
set -x PLANTUML_LIMIT_SIZE 8192

# Android SDK
set -x PATH ~/Library/Android/sdk/platform-tools $PATH

# rbenv
#set -x PATH $HOME/.rbenv/bin $PATH
#status --is-interactive; and source (rbenv init -|psub)

# mysql
fish_add_path /usr/local/opt/mysql-client/bin

# Created by `pipx` on 2025-03-10 02:45:01
set PATH $PATH /Users/hi/.local/bin
