# Load Node global installed binaries
export PATH="/opt/homebrew/opt/node@14/bin:$PATH"
export PATH="$HOME/.node/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Make sure coreutils are loaded before system commands
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# Local bin directories before anything else
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Load custom commands
export PATH="$DOTFILES/bin:$PATH"

# Define default starship config path
export STARSHIP_CONFIG="$DOTFILES/starship/starship.toml"

# Specify default editor. Possible values: vim, nano, code, ed etc.
export EDITOR=code
export VISUAL=code

# Specify my language environment, you can check your configs with `locale`
export LANG=en_CA.UTF-8
export LC_ALL=en_CA.UTF-8

# Opt-out of Homebrew's analytics
export HOMEBREW_NO_ANALYTICS=1

# Prevent Homebrew from following redirects from HTTPS to HTTP
export HOMEBREW_NO_INSECURE_REDIRECT=1

# Abort installation of a cask if no checksum is defined
export HOMEBREW_CASK_OPTS=--require-sha

# For psycopg2, see: https://github.com/psycopg/psycopg2/issues/890
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include -I/opt/homebrew/include -L/opt/homebrew/lib"
export PYCURL_SSL_LIBRARY=openssl

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

if [[ -n "$DOTFILES_DEBUG" ]]; then
    echo "[-] exports.zsh loaded"
fi;