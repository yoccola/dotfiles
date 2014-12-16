# vim: set nowrap filetype=zsh:
# 
# See README.md.
#
fpath=($fpath `dirname $0`)

# Default timeout is 30 seconds.
[[ $NOTIFY_COMMAND_COMPLETE_TIMEOUT == "" ]]  \
  && NOTIFY_COMMAND_COMPLETE_TIMEOUT=30

# Notify an error with no regard to the time elapsed (but always only
# when the terminal is in background).
function notify-error {
  local icon
  icon="/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertStopIcon.icns"
  notify-if-background -t "#fail" --image "$icon" < /dev/stdin &!
}

# Notify of successful command termination, but only if it took at least
# 30 seconds (and if the terminal is in background).
function notify-success() {
  local now diff notify_start_time notify_last_command

  notify_start_time=$1
  notify_last_command="$2"
  now=`date "+%s"`

  ((diff = $now - $notify_start_time ))
  if (( $diff > $NOTIFY_COMMAND_COMPLETE_TIMEOUT )); then
    notify-if-background -t "#win" <<< "$notify_last_command" &!
  fi
}

# Notify about the last command's success or failure.
function notify-command-complete() {
  last_status=$?
  if [[ $last_status -gt "0" ]]; then
    notify-error <<< $notify_last_command
  elif [[ -n $notify_start_time ]]; then
    notify-success "$notify_start_time" "$notify_last_command"
  fi
  unset notify_last_command notify_start_time last_status
}

function store-command-stats() {
  notify_last_command=$1
  notify_last_command_name=${1[(wr)^(*=*|sudo|ssh|-*)]}
  notify_start_time=`date "+%s"`
}

autoload add-zsh-hook
autoload -U tell-terminal
autoload -U tell-iterm2
autoload -U notify-if-background
add-zsh-hook preexec store-command-stats
add-zsh-hook precmd notify-command-complete
