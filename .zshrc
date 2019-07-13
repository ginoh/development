#####################################################################
#
#  Sample .zshrc file
#  initial setup file for only interactive zsh
#  This file is read after .zshenv file is read.
#
#####################################################################

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
    if brew list anyenv > /dev/null 2>&1; then                                                                                  
    eval "$(anyenv init -)"                                                                                                     
    fi                                                                                                                          
                                                                                                                                
fi 

if [ -n GOPATH ]; then                                                                                                          
    export PATH=${GOPATH}/bin:${PATH}                                                                                           
    # see https://github.com/motemen/ghq                                                                                        
    #export GHQ_ROOT="${GOPATH}/src"                                                                                            
fi 

### common env                                                                                                                  
export PATH=${HOME}/.bin:${PATH}                                                                                                
                                                                                                                                
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
## kubectl                                                                                                                      
alias kc="kubectl"

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
PROMPT=$'\n[%~]\n{%F{cyan}%n%f@%F{green}%m%f}%# '  

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
