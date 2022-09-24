if [ "$(uname)" = "Linux" ]; then
    #env
    export LANG="ja_JP.utf8"
    export LC_TIME="en_US.utf8"
    export LC_MESSAGES="ja_JP.utf8"

    # alias
    alias ls="ls -a -F --color"

    # anyenv for Linux
    if [ -e ${HOME}/.anyenv/bin ]; then
	    export PATH=${HOME}/.anyenv/bin:${PATH}
        # faster startup
        if [ -f $HOME/.anyenv-rc.sh ]; then
            source $HOME/.anyenv-rc.sh
        else
            eval "$(anyenv init -)"
        fi
    fi
elif [ "$(uname)" = "Darwin" ]; then
    #env
    export LANG="ja_JP.UTF-8"
    export LC_TIME="en_US.UTF-8"
    export LC_MESSAGES="ja_JP.UTF-8"

    # alias
    alias ls="ls -a -F -G"

    # # anyenv for Mac
    if type anyenv > /dev/null 2>&1; then
        # faster startup
        if [ -f $HOME/.anyenv-rc.sh ]; then
            source $HOME/.anyenv-rc.sh
        else
            eval "$(anyenv init -)"
        fi
    fi
fi

### Go
if [ -n GOPATH ]; then
    export PATH=${PATH}:${GOPATH}/bin
fi


### common env
export PATH=${HOME}/bin:${PATH}

### krew
export PATH=${KREW_ROOT:-$HOME/.krew}/bin:$PATH

#### alias
alias ll="ls -l"
## screen
alias scr='screen -U'
alias scrr='scr -r'
alias scrl='scr -ls'
## tmux
alias tm="tmux"
alias tma="tmux attach"
alias tml="tmux ls"
## k8s
alias kc="kubectl"
alias kctx="kubectx"
alias kb="kubebuilder"
# ## python
# alias python="python3"
## gcp
alias gssh="gcloud compute ssh"
alias gscp="gcloud compute scp"
alias gclist="gcloud compute instances list"
alias gconfig="gcloud config"

## mysql5.7
alias mysql57="/usr/local/opt/mysql-client@5.7/bin/mysql"


# global alias
alias -g L='| less'
alias -g G='| grep'
alias -g GV='| grep -v grep'
alias -g EG='| egrep'
alias -g T='| tail'
alias -g H='| head'
alias -g W='| wc'
alias -g S='| sort'

# PROMPT
HISTSIZE=1000 HISTFILE=~/.zhistory SAVEHIST=1000

## The following is a command to check the color.
## for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
### for light
PROMPT=$'\n[%~]\n(%D{%Y-%m-%dT%T%z})\n{%F{033}%n%f@%F{034}%m%f}%# '
### for dark
#PROMPT=$'\n[%~]\n(%D{%Y-%m-%dT%T%z})\n{%F{cyan}%n%f@%F{green}%m%f}%# '

# zsh option
setopt auto_cd auto_pushd auto_remove_slash auto_name_dirs
setopt extended_history hist_ignore_dups hist_ignore_space prompt_subst
setopt extended_glob list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys pushd_ignore_dups
unsetopt prompt_cr

# function
function chpwd() { ls }
function anyenv-init() { eval "$(anyenv init -)" }

# ghq && fzf
# https://github.com/junegunn/fzf
if type ghq > /dev/null 2>&1 && 
    type fzf > /dev/null 2>&1; then
    function ghq-select() {
        local command="cd"

        if [ "path" = "$1" ]; then
            command="echo"
            shift
        fi

        if [ "root" = "$1" ]; then
            $command $(ghq root)
        else
            local repos=$(ghq list $@)
            if [ -z "$repos" ];then
                echo "No candidates found"
            else
                $command $(ghq root)/$(echo "$repos" | fzf)
            fi
        fi
    }
fi

# zsh binding keys
bindkey -e

# completion
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
autoload -U compinit && compinit

# load zsh completion files
[ -e ${HOME}/.zshcomp -a -d ${HOME}/.zshcomp ] && for file in `ls ${HOME}/.zshcomp/*`;do source $file; done

# zmv
autoload -U zmv
