# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dstokes"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode history-substring-search gpg-agent)

source $ZSH/oh-my-zsh.sh

# Source dotfiles
for dotf in ~/.{aliases,exports,functions,localrc}; do
  [ -r "$dotf" ] && source "$dotf"
done

setopt no_share_history
setopt HIST_IGNORE_SPACE
unsetopt CORRECT
unsetopt CORRECT_ALL
DISABLE_AUTO_TITLE=true
DISABLE_CORRECTION=true
#skip_global_compinit=1

# free up <C-S> for vim
stty -ixon -ixoff

# re-enable bash-y history search
bindkey '^R' history-incremental-search-backward

# PS1="\[\033[35m\]`date +"[%a %Y-%m-%d %H:%M:%S]"`\[\033[m\] \[\e[1;32m\]\u@\H:\[\e[m\]\[\e[1;37m\]\w\[\e[m\]  \[\033[36m\][`wget -qO- ifconfig.me/ip`]\[\033[36m\] \[\033[37m\]\$\[\033[0m\] "

#RPROMPT='%{$fg_bold[blue]%}[%!][$(date +%T)] % %{$reset_color%}'
ZLE_RPROMPT_INDENT=0

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/go/bin
export PATH="$PATH:$HOME/.local/bin/:$GOPATH/bin"
export PATH="/opt/homebrew/bin:opt/homebrew/sbin:$PATH"

if [[ -f ~/.gnupg/gpg-agent.env ]]; then
  source ~/.gnupg/gpg-agent.env
  export GPG_AGENT_INFO
  export SSH_AUTH_SOCK
else
  export SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.ssh
fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
. "$HOME/.cargo/env"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
