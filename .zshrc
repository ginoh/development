#####################################################################
#
#  Sample .zshrc file
#  initial setup file for only interactive zsh
#  This file is read after .zshenv file is read.
#
#####################################################################

# Set Enviroment variable
export LANG=ja_JP.UTF-8
export PATH=$HOME/.nodebrew/current/bin:$PATH

# gvm (for go)
if [ -s ~/.gvm/scripts/gvm ];then
   . ~/.gvm/scripts/gvm
fi

# Set Shell variable
HISTSIZE=200 HISTFILE=~/.zhistory SAVEHIST=180

PROMPT=$'\n[%~]\n%{\e[31m%}%n%{\e[m%}@{%{\e[34m%}%m%{\e[m%}}%# '

# Set shell options
setopt auto_cd auto_pushd auto_remove_slash auto_name_dirs 
setopt extended_history hist_ignore_dups hist_ignore_space prompt_subst
setopt extended_glob list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys pushd_ignore_dups

# 空白行の出力がわからなくなるためoptionをunset
unsetopt prompt_cr

alias tm='tmux'
alias tma='tmux -t'

# BSD&Mac ls
#alias ls='ls -FG'
# Linux ls
alias ls='ls -aF'
alias ll='ls -aF -l'
alias lsc='ls --color'

#screen for UTF-8
alias scr='screen -U'
alias scrr='scr -r'
alias scrl='scr -ls'

# global alias
alias -g L='| less'
alias -g G='| grep'
alias -g GV='| grep -v grep'
alias -g EG='| egrep'
alias -g T='| tail'
alias -g H='| head'
alias -g W='| wc'
alias -g S='| sort'

# directory移動時に自動でls
function chpwd() { ls }

# binding keys
bindkey -e
#bindkey '^p'	history-beginning-search-backward
#bindkey '^n'	history-beginning-search-forward

# 補完関連
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
autoload -U compinit && compinit

# renameなどを便利に
autoload zmv
