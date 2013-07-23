# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

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
plugins=(git npm vi-mode history-substring-search)

source $ZSH/oh-my-zsh.sh
source ~/.aliases
setopt no_share_history
unsetopt correct
unsetopt correct_all
DISABLE_AUTO_TITLE="true"
DISABLE_CORRECTION="true"
skip_global_compinit=1

# load super secret local configuration
if [[ -a ~/.localrc ]]; then
  source ~/.localrc
fi

# Set the name of the current tmux window to the current
# directory if in a git repo, otherwise restore the automatic-rename option
precmd() {
  repo=$(git rev-parse --show-toplevel 2> /dev/null)
  if [[ -n "$TMUX" ]]; then
    if [[ -n "$repo" ]]; then
      tmux rename-window $(basename "$repo")
    else
      tmux set-window-option -q automatic-rename on
    fi
  fi
  unset repo
};


# Customize to your needs...
export PATH=/Users/dev/Documents/phpunit-git-deploy/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/dev/Documents/phpunit-git-deploy/bin:/Users/dev/Sites/beachmint/packages/bin
