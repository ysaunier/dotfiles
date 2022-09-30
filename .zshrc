source virtualenvwrapper.sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
# ZSH_THEME="agnoster"

# ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="powerlevel10k/powerlevel10k"

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
#         prompt_segment 4 255
#         print -Pn "$(basename $USER)"
#     fi
# }

prompt_assumed_role() {
    # See: https://github.com/ohmyzsh/ohmyzsh/blob/c66d8a841d231895be37721220f23b537d90c5a5/themes/agnoster.zsh-theme#L246
    if [[ -n $ASSUMED_ROLE ]]; then
        if [[ $ASSUMED_ROLE == *"prod"* ]]; then
            local color='%F{red}'
            local aws_env="prod"
        elif [[ $ASSUMED_ROLE == *"stage"* ]]; then
            local color='%F{orange}'
            local aws_env="stage"
        else
            local color='%F{green}'
            local aws_env="dev"
        fi

        #prompt_segment $color 255
        # print -Pn "$(basename $aws_env)"
        echo -n "%{$color%}$aws_env%{%f%}"

        if [[ $joined == false ]]; then
            # Middle segment
            echo -n "$(print_icon 'LEFT_SEGMENT_SEPARATOR')$POWERLEVEL9K_WHITESPACE_BETWEEN_LEFT_SEGMENTS"
        fi
    fi
}

# Segment to display the current AWS Details
prompt_aws_details2() {
    local ROOT_PREFIX="${3}"
    local background_color="green"

    if [[ -n $AWS_PROFILE ]]; then
        if [[ $AWS_PROFILE == *"prod"* ]]; then
            local aws_profile="prod"
            background_color="red"
        elif [[ $AWS_PROFILE == *"stage"* ]]; then
            local aws_profile="stage"
            background_color="orange"
        else
            local aws_profile="dev"            
        fi
    fi
    if [[ -n $AWS_DEFAULT_REGION ]]; then
        local aws_region=$AWS_DEFAULT_REGION
    fi

    echo "$1_prompt_segment"
    echo "$0"
    echo "$1"
    echo "$2"
    echo "$background_color"


    # if [[ -n $aws_profile ]] && [[ -n $aws_region ]]; then
    #     echo "$1_prompt_segment" "$0" "$2" "$background_color" "white" "$aws_profile:$aws_region"
    # elif [[ -n $aws_profile ]]; then
    #     echo "$1_prompt_segment" "$0" "$2" "$background_color" "white" "$aws_profile"
    # elif [[ -n $aws_region ]]; then
    #     echo "$1_prompt_segment" "$0" "$2" "$background_color" "white" "$aws_region"
    # fi
}


prompt_aws_profile() {
    if [[ -n $AWS_PROFILE ]]; then
        if [[ $AWS_PROFILE == *"prod"* ]]; then
            local color='%F{red}'
            local aws_profile="PROD"
        elif [[ $AWS_PROFILE == *"stage"* ]]; then
            local color='%F{orange}'
            local aws_profile="STAGE"
        else
            local color='%F{green}'
            local aws_profile="DEV"
        fi
        #print -Pn "$(basename profile:$aws_profile)"
        echo -n "%{$color%}$aws_profile%{%f%}" # \uf230 is 
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
        #prompt_segment 93 255
        print -Pn "$(basename $info)"
    elif [[ -n $aws_profile ]]; then
        #prompt_segment 93 255
        print -Pn "$(basename $aws_profile)"
    elif [[ -n $aws_region ]]; then
        #prompt_segment 93 255
        print -Pn "$(basename $aws_region)"
    fi
}

prompt_color_test() {
    for a in {0..255}; do
        #prompt_segment $a 0
        print -Pn "$(basename $a)"
    done
}

# build_prompt() {
#     RETVAL=$?
#     prompt_status
#     prompt_virtualenv
#     prompt_context
#     prompt_assumed_role
#     prompt_aws_details
#     prompt_dir
#     prompt_git
#     prompt_bzr
#     prompt_hg
#     # prompt_color_test
#     prompt_end
# }

# Virtualenv: current working virtualenv
# More information on virtualenv (Python):
# https://virtualenv.pypa.io/en/latest/
# prompt_virtualenv_name() {
#   # Early exit; $virtualenv_path must always be set.
#   [[ -z "$VIRTUAL_ENV" ]] && return
#   local virtualenv_name=$(grep -F 'prompt'  $VIRTUAL_ENV/pyvenv.cfg | cut -c 11- | tr -d \'\))

#   # "$1_prompt_segment" "$0" "$2" "purple" "$DEFAULT_COLOR" "${virtualenv_name}"
#   p10k segment -b 1 -f 3 -i '⭐' -t 'hello, %n'
# }

# # Current version of python
# prompt_python_version() {
#     [[ -z "$VIRTUAL_ENV" ]] && return

#     local py_version=$(python --version)
#     [[ -z "$py_version" ]] && return

#     "$1_prompt_segment" "$0" "$2" "deepskyblue4" "gold3" "${py_version}"
# }

# # Current AWS informations
# prompt_aws_info() {
#     local bg_color="darkseagreen"
#     local aws_info=""
#     if [[ -n $AWS_PROFILE ]]; then
#         if [[ $AWS_PROFILE == *"prod"* ]]; then
#             aws_info="prod"
#             bg_color="darkred"
#         elif [[ $AWS_PROFILE == *"stage"* ]]; then
#             aws_info="stage"
#             bg_color="gold3"
#         else
#             aws_info="dev"
#         fi
#     fi
#     if [[ -n $AWS_DEFAULT_REGION ]]; then
#         aws_info+=":$AWS_DEFAULT_REGION"
#     fi

#     [[ -z $aws_info ]] && return

#     "$1_prompt_segment" "$0" "$2" "$bg_color" "$DEFAULT_COLOR" "${aws_info}" 'AWS_ICON'
# }

# POWERLEVEL9K_CUSTOM_VIRTUALENV_NAME="prompt_virtualenv_name"
# POWERLEVEL9K_CUSTOM_PYTHON_VERSION="prompt_python_version"
# POWERLEVEL9K_CUSTOM_AWS_INFO="prompt_aws_info"

# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context time battery dir vcs virtualenv custom_wifi_signal)

# POWERLEVEL9K Theme Config
# POWERLEVEL9K_MODE='nerdfont-complete'
# POWERLEVEL9K_MODE='compatible'
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(python_version virtualenv_name context dir)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status aws_info vcs)

# POWERLEVEL9K_OS_ICON_BACKGROUND=024 #navyblue
# POWERLEVEL9K_OS_ICON_FOREGROUND=202 #orangered1
# POWERLEVEL9K_CONTEXT_TEMPLATE='%n'
# POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND=249 # white
# POWERLEVEL9K_DIR_HOME_FOREGROUND=249
# POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=249
# POWERLEVEL9K_DIR_ETC_FOREGROUND=249
# POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=249
# POWERLEVEL9K_DIR_HOME_BACKGROUND=024 #deepskyblue4a
# POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=024 #deepskyblue4a
# POWERLEVEL9K_DIR_ETC_BACKGROUND=024 #deepskyblue4a
# POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=024 #deepskyblue4a
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# POWERLEVEL9K_HOME_ICON=''
# POWERLEVEL9K_HOME_SUB_ICON=''
# POWERLEVEL9K_FOLDER_ICON=''
# POWERLEVEL9K_STATUS_VERBOSE=true
# POWERLEVEL9K_STATUS_CROSS=true
# POWERLEVEL9K_STATUS_OK_BACKGROUND=017
# POWERLEVEL9K_STATUS_ERROR_BACKGROUND=017
# POWERLEVEL9K_VCS_CLEAN_FOREGROUND=017 # navyblue
# POWERLEVEL9K_VCS_CLEAN_BACKGROUND=040 # green3a
# POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=017 # navyblue
# POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=220 # gold1
# POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=236 #grey19
# POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=160 #red3a
# POWERLEVEL9K_SHOW_CHANGESET=true

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
