# Completion system (replaces oh-my-zsh)
autoload -Uz compinit && compinit

# Vi mode
bindkey -v

# History substring search (replaces oh-my-zsh plugin)
source "$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Source dotfiles
for dotf in ~/.{aliases,exports,functions,localrc}; do
  [ -r "$dotf" ] && source "$dotf"
done

setopt no_share_history
setopt HIST_IGNORE_SPACE
unsetopt CORRECT
unsetopt CORRECT_ALL
DISABLE_AUTO_TITLE=true

# free up <C-S> for vim
stty -ixon -ixoff

# re-enable bash-y history search
bindkey '^R' history-incremental-search-backward

ZLE_RPROMPT_INDENT=0

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/go/bin
export PATH="$PATH:$HOME/.local/bin/:$GOPATH/bin"
export PATH="/opt/homebrew/bin:opt/homebrew/sbin:$PATH"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# lazy-load NVM — defers ~300ms of startup until first use
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}
node() { nvm --version > /dev/null 2>&1; node "$@"; }
npm() { nvm --version > /dev/null 2>&1; npm "$@"; }
npx() { nvm --version > /dev/null 2>&1; npx "$@"; }

eval "$(starship init zsh)"