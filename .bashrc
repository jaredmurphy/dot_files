#  _              _
# | |__  __ _ ___| |__   _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|

# history
# http://jorge.fbarr.net/2011/03/24/making-your-bash-history-more-efficient/
# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE

# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

# Ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# Make some commands not show up in history
export HISTIGNORE="h"

# sourced scripts
if [ -f ~/.bash_aliases.sh ]; then
  source ~/.bash_aliases.sh
fi

if [ -f ~/.bash_prompt.sh ]; then
  source ~/.bash_prompt.sh
fi

# felix gray
if [ -f ~/.bash_felixgray.sh ]; then
  source ~/.bash_felixgray.sh
fi

# rbenv setup
eval "$(rbenv init -)"
export PATH="/usr/local/opt/openssl/bin:$PATH"

# nvm setup
source $(brew --prefix nvm)/nvm.sh
export NVM_DIR=~/.nvm

# ignore case sensitivity for tab completion
bind 'set completion-ignore-case on'

# functions
rogue() {
  local PORTS="3000 3500 4567 6379 8000 8888 27017 9292 8080 3001 4000 9200 9300"
  local MESSAGE="> Checking for processes on ports"
  local COMMAND="lsof"

  for PORT in $PORTS; do
    MESSAGE="${MESSAGE} ${PORT},"
    COMMAND="${COMMAND} -i TCP:${PORT}"
  done

  echo "${MESSAGE%?}..."
  local OUTPUT="$(${COMMAND})"

  if [ -z "$OUTPUT" ]; then
    echo "> Nothing running!"
  else
    echo "> Processes found:"
    printf "\n$OUTPUT\n\n"
    echo "> Use the 'kill' command with the 'PID' of any process you want to quit."
    echo
  fi
}

