# Edit my zsh configs
alias zshconfig='$EDITOR ~/.dotfiles/.zshrc'

# Edit my aliases
alias aliases='$EDITOR ~/.dotfiles/aliases.zsh'

# Edit my extra configs
alias extras='$EDITOR ~/.dotfiles/extra.zsh'

# Open my local scratchpad
SCRATCHFILE=~/scratchpad.txt
alias scratchpad='echo "\n\n$(date):\n=============================\n" >> $SCRATCHFILE; $EDITOR $SCRATCHFILE'
alias sp='scratchpad'

# Edit my hosts file
alias hosts='sudo $EDITOR /etc/hosts'

# Edit my SSH hosts config
alias hostconf='$EDITOR ~/.ssh/config'

# Reload my CLI configs
alias reload="source ~/.zshrc; echo 'ZSH reloaded.'"

# Restart the computer
alias restart="sudo shutdown -r now"

## Colorize the ls output ##
alias ls='ls --color=auto'

## Use a long listing format ##
alias ll='ls -la'

## Show hidden files ##
alias l.='ls -d .* --color=auto'

# Navigation
## get rid of command not found ##
alias cd..='cd ..'
## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .54='cd ../../../../'
alias .65='cd ../../../../../'
alias .76='cd ../../../../../../'

alias dl='cd ~/Downloads;pwd'
alias df="cd $DOTFILES;pwd"
alias cdaws="cd ~/.aws"
alias library="cd $HOME/Library"
alias projects="cd $PROJECTS;pwd"
alias poka="cd $PROJECTS/poka;pwd"
alias instance-service="cd $PROJECTS/instance-service;pwd"

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias calc='bc -l'
alias mkdir='mkdir -pv'
alias diff='colordiff'

# handy short cuts #
alias h='history|grep '
alias j='jobs -l'

# Application launchers
alias cat='bat'
alias woman=tldr # Grace Hopper approved
alias chromeopen='/usr/bin/open -a "/Applications/Google Chrome.app"'

# Prompt for confirmation before overwriting or deleting a file when copying/moving
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'

# Show/hide hidden files in Finder
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'

# Show/hide all desktop icons (useful when presenting)
alias hidedesktop='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
alias showdesktop='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"

# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill='ps ux | grep '\''[C]hrome Helper --type=renderer'\'' | grep -v extension-process | tr -s '\'' '\'' | cut -d '\'' '\'' -f2 | xargs kill'

# Kill a runaway docker run command, when your test suite just don't want to finish...
alias dockerrunkill='ps | grep '\''docker run'\'' | grep -v grep | awk '\''{print $1}'\'' | xargs kill -9'

# For those times when you just don't look busy enough
alias busy='export GREP_COLOR='\''1;32'\''; cat /dev/urandom | hexdump -C | grep --color=auto "ca fe"'

# Display a notification
# (useful when executing time-consuming commands)
alias notify='/usr/bin/osascript -e "display notification \"Finished!\" with title \"Zsh\""'

# Get week number
alias week='date +%V'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Get macOS Software Updates, update Homebrew and its installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew upgrade --cask; brew cleanup; mas upgrade;tldr --update'

# Check if I've got outdated versions of applications
alias outdated='brew outdated; mas outdated'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip='ipconfig getifaddr en0'
alias ips='ifconfig -a | grep -o '\''inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)'\'' | awk '\''{ sub(/inet6? (addr:)? ?/, ""); print }'\'''

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Flush Directory Service (DNS) cache
alias flush='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

alias ports='netstat -tulanp'

## get top process eating memory
alias psmem='ps aux | sort -nr -k 4'
alias psmem10='ps aux | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps aux | sort -nr -k 3'
alias pscpu10='ps aux | sort -nr -k 3 | head -10'

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# Show how much diskspace I got left (shouldn't have bought that puny 128GB MBA...)
alias diskspace="df -P -kHl"

# Clean-up the temporary/cache files in a Python project
alias pyclean='find . -name "*.py[co]" -o -name __pycache__ -exec rm -rf {} +'

# Clean-up any dependencies that were installed outside a virtual environment
alias pipclean="pip list | awk '{if (NR>2) print $1}' | grep -v pip | grep -v setuptools | xargs pip uninstall -y"
alias pip3clean="pip3 list | awk '{if (NR>2) print $1}' | grep -v pip | grep -v setuptools | xargs pip uninstall -y"

# Setup python venv
# alias venv='python3 -m venv .venv && . .venv/bin/activate && python3 -m pip install -q --upgrade pip'
function venv() {
    echo $1
    return
    python3 -m venv .venv --prompt $1
    . .venv/bin/activate
    python3 -m pip install -q --upgrade pip
}

# Run GUI Datadog Agent
alias ddog="datadog-agent launch-gui"

alias poka_dev_tests="TEST_DATABASE_MIGRATION_CHECK=True py.test -n auto --runslow --randomly-dont-reset-seed  --disable-warnings --ds=settings.test_psql -x tests"
alias pdt="poka_dev_tests"

function poka_set_users() {
  local _query="UPDATE auth_user SET password='pbkdf2_sha256\$260000\$cXUbGLmKG78vfGkQeDLiv3\$iFWq5QiElTjEXyFVxLAJJ7VV8zucMUnH7I0DDHNKnOc=' WHERE username!='arusso'"
  psql --host=localhost --username=poka_dev -c "$_query"
}

# MISC
alias holdmybeer=sudo
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias tableflip="echo '(╯°□°）╯︵ ┻━┻' | pbcopy"
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]' | pbcopy"

# Functions
weather() { curl -4 fr.wttr.in/${1:-"quebec city"} }
tobase64() { echo "$1" | base64 | tr -d '\n' | tr -d ';' | pbcopy }
pokabe() { curl -s -f -X GET "$1/api/v2.3/public/server-info/?fields=backend_version" | jq '.backend_version' | cut -d '"' -f 2 }
pokafe() { curl -s -f -X GET "$1/webapp-version" | cut -f 1 }
pokainfo() { curl -s -f -X GET "$1/api/v2.3/public/server-info/?fields=backend_version,client_code,environment,tenant_code,tenant_id" | jq }

function pokasso() {
  eval $(~/.dotfiles/bin/pokaco $1 $2)
}

# Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
        local arg=-sbh;
    else
        local arg=-sh;
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@";
    else
        du $arg .[^.]* ./*;
    fi;
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-9000}"
    sleep 2 && open "http://localhost:${port}/" &
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python3 -c "from http.server import test, SimpleHTTPRequestHandler as RH; RH.extensions_map = {k: v + ';charset=UTF-8' for k, v in RH.extensions_map.items()}; test(HandlerClass=RH, port=${port}, bind=None)"
}

# Scrape a single webpage with all assets
function scrapeUrl() {
    wget --adjust-extension --convert-links --page-requisites --span-hosts --no-host-directories "$1"
}

# Shortcut for the OSX quick-look command
function ql() {
   quick-look "$1"
}

# Function to easily match text using regexes in a command pipeline, second param is the capture group number
# e.g. `find . -name '*.py' | xargs cat | regex '^class (\w+)' 1 | sort | uniq` to find all the classes in a Py project
function regex() {
    gawk 'match($0,/'$1'/, ary) {print ary['${2:-'0'}']}';
}

# When you want the length of a string and wc won't do
function length() {
    awk '{print length, $0}'
}

# Git checkout with branch name autocomplete using fzf (from: https://elijahmanor.com/byte/git-recent-branches)
alias cb='git branch --sort=-committerdate | fzf --header Checkout | xargs git checkout'

# Tmux shortcuts (from: https://github.com/everzet/dotfiles/blob/master/zsh/aliases.zsh)
alias tn='tmux new-session -s ${PWD##*/}'
alias ta='tmux attach -t'
alias tls='tmux list-sessions'
alias tks='tmux kill-session -t'
alias mux='tmuxinator'

function poka_find_url() {
    ./manage.py show_urls --settings=settings.dev | grep -i '/api/v2.3/' |  grep -i $1
}

function docker-bash() {
    docker exec -it $1 bash
}

if [[ -n "$DOTFILES_DEBUG" ]]; then
    echo "[-] aliases.zsh loaded"
fi;