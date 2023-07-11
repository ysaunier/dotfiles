## # Get the list of submodules from .gitmodules
## DOTFILES_SUBMODULES=$(git submodule status | cut -d ' ' -f 3)
##
## # Include scripts in Bin
## export PATH=$HOME/.dotfiles/bin:$PATH
## for submodule in "${DOTFILES_SUBMODULES[@]}"; do
##     [[ ! -d "$HOME/.dotfiles/$submodule/bin" ]] || export PATH=$HOME/.dotfiles/$submodule/bin:$PATH
## done
#
#autoload -Uz vcs_info
#precmd() { vcs_info }
#
#zstyle ':vcs_info:git:*' formats '%b '
#
#setopt PROMPT_SUBST
#PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '
#
#prompt_assumed_role() {
#    # See: https://github.com/ohmyzsh/ohmyzsh/blob/c66d8a841d231895be37721220f23b537d90c5a5/themes/agnoster.zsh-theme#L246
#    if [[ -n $ASSUMED_ROLE ]]; then
#        if [[ $ASSUMED_ROLE == *"prod"* ]]; then
#            local color='%F{red}'
#            local aws_env="prod"
#        elif [[ $ASSUMED_ROLE == *"stage"* ]]; then
#            local color='%F{orange}'
#            local aws_env="stage"
#        else
#            local color='%F{green}'
#            local aws_env="dev"
#        fi
#
#        #prompt_segment $color 255
#        # print -Pn "$(basename $aws_env)"
#        echo -n "%{$color%}$aws_env%{%f%}"
#
#        if [[ $joined == false ]]; then
#            # Middle segment
#            echo -n "$(print_icon 'LEFT_SEGMENT_SEPARATOR')$POWERLEVEL9K_WHITESPACE_BETWEEN_LEFT_SEGMENTS"
#        fi
#    fi
#}
#
## Segment to display the current AWS Details
#prompt_aws_details2() {
#    local ROOT_PREFIX="${3}"
#    local background_color="green"
#
#    if [[ -n $AWS_PROFILE ]]; then
#        if [[ $AWS_PROFILE == *"prod"* ]]; then
#            local aws_profile="prod"
#            background_color="red"
#        elif [[ $AWS_PROFILE == *"stage"* ]]; then
#            local aws_profile="stage"
#            background_color="orange"
#        else
#            local aws_profile="dev"
#        fi
#    fi
#    if [[ -n $AWS_DEFAULT_REGION ]]; then
#        local aws_region=$AWS_DEFAULT_REGION
#    fi
#
#    echo "$1_prompt_segment"
#    echo "$0"
#    echo "$1"
#    echo "$2"
#    echo "$background_color"
#}
#
#prompt_aws_profile() {
#    if [[ -n $AWS_PROFILE ]]; then
#        if [[ $AWS_PROFILE == *"prod"* ]]; then
#            local color='%F{red}'
#            local aws_profile="PROD"
#        elif [[ $AWS_PROFILE == *"stage"* ]]; then
#            local color='%F{orange}'
#            local aws_profile="STAGE"
#        else
#            local color='%F{green}'
#            local aws_profile="DEV"
#        fi
#        #print -Pn "$(basename profile:$aws_profile)"
#        echo -n "%{$color%}$aws_profile%{%f%}" # \uf230 is 
#    fi
#}
#
#prompt_aws_details() {
#    if [[ -n $AWS_PROFILE ]]; then
#        if [[ $AWS_PROFILE == *"prod"* ]]; then
#            aws_profile="prod"
#        elif [[ $AWS_PROFILE == *"stage"* ]]; then
#            aws_profile="stage"
#        else
#            aws_profile="dev"
#        fi
#    fi
#    if [[ -n $AWS_DEFAULT_REGION ]]; then
#        aws_region=$AWS_DEFAULT_REGION
#    fi
#
#    if [[ -n $aws_profile ]] && [[ -n $aws_region ]]; then
#        info="$aws_profile:$aws_region"
#        #prompt_segment 93 255
#        print -Pn "$(basename $info)"
#    elif [[ -n $aws_profile ]]; then
#        #prompt_segment 93 255
#        print -Pn "$(basename $aws_profile)"
#    elif [[ -n $aws_region ]]; then
#        #prompt_segment 93 255
#        print -Pn "$(basename $aws_region)"
#    fi
#}
#
#prompt_color_test() {
#    for a in {0..255}; do
#        #prompt_segment $a 0
#        print -Pn "$(basename $a)"
#    done
#}
#
## export MANPATH="/usr/local/man:$MANPATH"
#
## You may need to manually set your language environment
## export LANG=en_US.UTF-8
#
## Preferred editor for local and remote sessions
## if [[ -n $SSH_CONNECTION ]]; then
##   export EDITOR='vim'
## else
##   export EDITOR='mvim'
## fi
#
## Compilation flags
## export ARCHFLAGS="-arch x86_64"
#
## ssh
## export SSH_KEY_PATH="~/.ssh/rsa_id"
#
## Set personal aliases, overriding those provided by oh-my-zsh libs,
## plugins, and themes. Aliases can be placed here, though oh-my-zsh
## users are encouraged to define aliases within the ZSH_CUSTOM folder.
## For a full list of active aliases, run `alias`.
##
## Example aliases
## alias zshconfig="mate ~/.zshrc"
## alias ohmyzsh="mate ~/.oh-my-zsh"
#
#prompt_context() {
#    if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
#      prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
#    fi
#}
#
#build_prompt() {
#    # RETVAL=$?
#    # prompt_status
#    prompt_context
#    prompt_dir
#    prompt_git
#    prompt_end
#}
#
#function replace_db() {
#  ORIGIN="$1"
#  DESTINATION="$HOME/Projects/poka/docker-compose/backup/db_backup.sql"
#
#  if [ -f "$ORIGIN" ]; then
#
#    # Unzip file if needed
#    if [[ "$ORIGIN" =~ \.gz$ ]]; then
#      echo "Unzip $ORIGIN..."
#      gzip -d -k "$ORIGIN"
#      ORIGIN=$(echo "$ORIGIN" | cut  -f 1 -d '.')
#    fi
#
#    rm -f "$DESTINATION"
#    echo "Move $ORIGIN to $DESTINATION..."
#    mv "$ORIGIN" "$DESTINATION"
#    echo "Next think about to run: cd ~/Projects/Poka; make reset-docker;"
#    echo "Done!"
#
#  else
#    echo "File $ORIGIN doesn't exist or is not a file"
#  fi
#}
#
#
#function notes(){
#  echo "# Assume Roles"
#  echo "eval \$(assume-role poka-stage-us-east-1)"
#  echo "eval \$(assume-role poka-dev-user)"
#  echo ""
#  echo "# Export Profiles"
#  echo "export AWS_PROFILE=poka-stage-us-east-1"
#  echo "export AWS_PROFILE=poka-dev-user"
#  echo ""
#  echo "# Export Regions"
#  echo "export AWS_DEFAULT_REGION=us-east-1"
#  echo "export AWS_DEFAULT_REGION=ca-central-1"
#  echo "export AWS_DEFAULT_REGION=eu-central-1"
#  echo ""
#  echo "# Deploy Instances"
#  echo "instance-service-ctl describe versions all --channel all"
#  echo "instance-service-ctl batch update-backend-version <instance_name> <image_name>"
#}
#
#
#function aws-poka-prod-assume(){
#  echo "eval \$(assume-role poka-prod-us-east-1)" | pbcopy
#}
#function aws-poka-stage-assume(){
#  echo "eval \$(assume-role poka-stage-us-east-1)" | pbcopy
#}
#function aws-poka-dev-assume(){
#  echo "eval \$(assume-role poka-dev-user)" | pbcopy
#}
#function aws-poka-prod-us1(){
#  echo "export AWS_PROFILE=poka-prod-us-east-1\nexport AWS_DEFAULT_REGION=us-east-1" | pbcopy
#}
#function aws-poka-prod-ca1(){
#  echo "export AWS_PROFILE=poka-prod-us-east-1\nexport AWS_DEFAULT_REGION=ca-central-1" | pbcopy
#}
#function aws-poka-prod-eu1(){
#  echo "export AWS_PROFILE=poka-prod-us-east-1\nexport AWS_DEFAULT_REGION=eu-central-1" | pbcopy
#}
#function aws-poka-stage-us1(){
#  echo "export AWS_PROFILE=poka-stage-us-east-1\nexport AWS_DEFAULT_REGION=us-east-1" | pbcopy
#}
#function aws-poka-stage-ca1(){
#  echo "export AWS_PROFILE=poka-stage-us-east-1\nexport AWS_DEFAULT_REGION=ca-central-1" | pbcopy
#}
#function aws-poka-stage-eu1(){
#  echo "export AWS_PROFILE=poka-stage-us-east-1\nexport AWS_DEFAULT_REGION=eu-central-1" | pbcopy
#}
#function aws-poka-dev-us1(){
#  echo "export AWS_PROFILE=poka-dev-user\nexport AWS_DEFAULT_REGION=us-east-1" | pbcopy
#}
#function aws-poka-dev-ca1(){
#  echo "export AWS_PROFILE=poka-dev-user\nexport AWS_DEFAULT_REGION=ca-central-1" | pbcopy
#}
#
#
#function aws-poka(){
#  params=($(echo "$1" | tr ":" "\n"))
#  echo ${params[1]}
#  echo ${params[2]}
#}
#
#function pv2(){
#  instance=$1
#  backend=$(curl -sb --request GET "https://$instance/version" | cut -c2-)
#  frontend=$(curl -sb --request GET "https://$instance/webapp-version" | cut -c2-)
#
#  echo "[-] $instance"
#  echo "Backend ...... : $backend"
#  echo "Frontend ..... : $frontend"
#}
#
#function pyc-clear(){
#  find . -type f -name '*.py[co]' -delete -print -o -type d -name __pycache__ -delete >/dev/null
#}
#
#function dbtext-clear(){
#  psql --host=localhost --username=poka_dev -c '\l' | awk '/test/ {print $1}' | xargs -I{} psql --host=localhost --username=poka_dev -c "DROP DATABASE {}"
#}
#
#function flush-redis(){
#  docker exec poka-backend_redis redis-cli FLUSHALL
#}
#

get_prompt_from_venv() {
    local pyvenv_cfg=$VIRTUAL_ENV/pyvenv.cfg

    if [ -f "$pyvenv_cfg" ]; then
        local ini_content=$(cat "$pyvenv_cfg")
        local prompt=$(echo "$ini_content" | grep prompt | cut -c 10-)
        echo "$prompt"
    fi
}


if [[ -n "$DOTFILES_DEBUG" ]]; then
    echo "[-] prompts.zsh loaded"
fi;