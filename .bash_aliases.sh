# bash
alias ls='ls -F'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias mkdir='mkdir -pv'
alias reload="clear; source ~/.bashrc"

# vim
alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'
alias snippets='vim /Users/jared/.vim/snippets'

# git
alias gacommit='git add . && git commit -m'
alias status='git status'
alias resetfile='git checkout HEAD -- '
alias squash='git rebase -i '

# tmux
alias tmuxn='tmux new-session -s'
alias tmuxa='tmux attach -t'
# for VIM and TMUX background color erase
alias tmux='tmux -2'  # for 256color

# rails
alias rs='rails server'
alias bi='bundle install'
alias bx='bundle exec'
alias rc='rails console'
alias rg='rails generate'
alias rmcache="echo 'flush_all' | nc localhost 11211 && rake tmp:cache:clear" # removes localhost:3000 cache

# node
alias npmt='npm run test'

# psql
alias resetPsql="cd ~/user/local/var/postgres && rm postmaster.pid && brew services restart postgresql"
alias pgstart='postgres -D /usr/local/var/postgres'

# ngrok
alias ngrok='cd /Applications/ && ./ngrok http 3000'

