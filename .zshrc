# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your dotfiles installation.
export DOTFILES=$HOME/.dotfiles

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$DOTFILES

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose zsh-autosuggestions)

# Activate Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# prompt_context() {
#     if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
#       prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
#     fi
# }

prompt_context() {
    if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        prompt_segment 4 255
        print -Pn "$(basename $USER)"
    fi
}

prompt_assumed_role() {
    # See: https://github.com/ohmyzsh/ohmyzsh/blob/c66d8a841d231895be37721220f23b537d90c5a5/themes/agnoster.zsh-theme#L246
    if [[ -n $ASSUMED_ROLE ]]; then
        if [[ $ASSUMED_ROLE == *"prod"* ]]; then
            color=124
            aws_env="prod"
        elif [[ $ASSUMED_ROLE == *"stage"* ]]; then
            color=208
            aws_env="stage"
        else
            color=34
            aws_env="dev"
        fi
        prompt_segment $color 255
        print -Pn "$(basename $aws_env)"
    fi
}

prompt_aws_profile() {
    if [[ -n $AWS_PROFILE ]]; then
        if [[ $AWS_PROFILE == *"prod"* ]]; then
            color=1
            aws_profile="prod"
        elif [[ $AWS_PROFILE == *"stage"* ]]; then
            color=3
            aws_profile="stage"
        else
            color=2
            aws_profile="dev"
        fi
        prompt_segment 93 255
        print -Pn "$(basename profile:$aws_profile)"
    fi
}

prompt_aws_details() {
    if [[ -n $AWS_PROFILE ]]; then
        if [[ $AWS_PROFILE == *"prod"* ]]; then
            aws_profile="prod"
        elif [[ $AWS_PROFILE == *"stage"* ]]; then
            aws_profile="stage"
        else
            aws_profile="dev"
        fi
    fi
    if [[ -n $AWS_DEFAULT_REGION ]]; then
        aws_region=$AWS_DEFAULT_REGION
    fi

    if [[ -n $aws_profile ]] && [[ -n $aws_region ]]; then
        info="$aws_profile:$aws_region"
        prompt_segment 93 255
        print -Pn "$(basename $info)"
    elif [[ -n $aws_profile ]]; then
        prompt_segment 93 255
        print -Pn "$(basename $aws_profile)"
    elif [[ -n $aws_region ]]; then
        prompt_segment 93 255
        print -Pn "$(basename $aws_region)"
    fi
}

prompt_color_test() {
    for a in {0..255}; do
        prompt_segment $a 0
        print -Pn "$(basename $a)"
    done
}



build_prompt() {
    RETVAL=$?
    prompt_status
    prompt_virtualenv
    prompt_context
    prompt_assumed_role
    prompt_aws_details
    prompt_dir
    prompt_git
    prompt_bzr
    prompt_hg
    # prompt_color_test
    prompt_end
}