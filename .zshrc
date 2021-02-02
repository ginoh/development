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
	eval "$(anyenv init -)"
    fi
elif [ "$(uname)" = "Darwin" ]; then
    #env
    export LANG="ja_JP.UTF-8"
    export LC_TIME="en_US.UTF-8"
    export LC_MESSAGES="ja_JP.UTF-8"

    # alias
    alias ls="ls -a -F -G"

    # anyenv for Mac
    if type anyenv > /dev/null 2>&1; then
	    #eval "$(anyenv init -)"
        if [ -f $HOME/.anyenvrc ]; then
            source $HOME/.anyenvrc
        fi
    fi
fi

### Go
if go version > /dev/null 2>&1; then
    export GO111MODULE="on"
    if [ -n GOPATH ]; then
            export PATH=${GOPATH}/bin:${PATH}
    fi
fi

### common env
export PATH=${HOME}/bin:${PATH}

### krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

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
## python
alias python="python3"
## gcp
alias gssh="gcloud compute ssh"
alias gscp="gcloud compute scp"
alias gclist="gcloud compute instances list"
alias gconfig="gcloud config"

## ghq
if type ghq > /dev/null 2>&1; then
    alias ghq-root="cd $(ghq root)"
    alias ghq-list="ghq list"
fi

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
PROMPT=$'\n[%~]\n(%D{%Y-%m-%dT%T%z})\n{%F{cyan}%n%f@%F{green}%m%f}%# '

# zsh option
setopt auto_cd auto_pushd auto_remove_slash auto_name_dirs
setopt extended_history hist_ignore_dups hist_ignore_space prompt_subst
setopt extended_glob list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys pushd_ignore_dups
unsetopt prompt_cr

# function
function chpwd() { ls }

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

