# Load Node global installed binaries
export PATH="/opt/homebrew/opt/node@14/bin:$PATH"

# Use ruby global installed
export PATH=/usr/local/Cellar/ruby/3.0.2/bin:$PATH

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Make sure coreutils are loaded before system commands
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# Local bin directories before anything else
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Load custom commands
export PATH="$DOTFILES/bin:$PATH"

# Add Python versions installed with pyenv to the PATH
eval "$(pyenv init --path)"

# Specify default editor. Possible values: vim, nano, ed etc.
#export EDITOR=nvim
#export VISUAL=nvim
export EDITOR=nano
export VISUAL=nano

# Specify my language environment, you can check your configs with `locale`
export LANG=en_CA.UTF-8
export LC_ALL=en_CA.UTF-8

# Opt-out of Homebrew's analytics
export HOMEBREW_NO_ANALYTICS=1

# Prevent Homebrew from following redirects from HTTPS to HTTP
export HOMEBREW_NO_INSECURE_REDIRECT=1

# Abort installation of a cask if no checksum is defined
export HOMEBREW_CASK_OPTS=--require-sha

# Python
# VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

# For psycopg2, see: https://github.com/psycopg/psycopg2/issues/890
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

export PATH="$HOME/.pyenv/bin:$PATH"

# export WORKON_HOME=$HOME/.virtualenvs
# export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

#for submodule in "${DOTFILES_SUBMODULES[@]}"; do
#    [[ ! -f "$submodule/exports.zsh" ]] || source "$submodule/exports.zsh"
#done