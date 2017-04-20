# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dstokes"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode history-substring-search gpg-agent)

PYTHONUNBUFFERED=1

source $ZSH/oh-my-zsh.sh
source ~/.aliases
source ~/.functions
setopt no_share_history
unsetopt correct
unsetopt correct_all
DISABLE_AUTO_TITLE="true"
DISABLE_CORRECTION="true"
skip_global_compinit=1

# free up <C-S> for vim
stty -ixon -ixoff

# re-enable bash-y history search
bindkey '^R' history-incremental-search-backward

# PS1="\[\033[35m\]`date +"[%a %Y-%m-%d %H:%M:%S]"`\[\033[m\] \[\e[1;32m\]\u@\H:\[\e[m\]\[\e[1;37m\]\w\[\e[m\]  \[\033[36m\][`wget -qO- ifconfig.me/ip`]\[\033[36m\] \[\033[37m\]\$\[\033[0m\] "

#RPROMPT='%{$fg_bold[blue]%}[%!][$(date +%T)] % %{$reset_color%}'
ZLE_RPROMPT_INDENT=0

# export bc config
export BC_ENV_ARGS=~/.bcrc

export TERM='xterm-256color'
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/go/bin

if [[ -f ~/.gnupg/gpg-agent.env ]]; then
  source ~/.gnupg/gpg-agent.env
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
fi

# load super secret local configuration
if [[ -a ~/.localrc ]]; then
  source ~/.localrc
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
