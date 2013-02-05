export PATH=/usr/local/bin:$PATH
export TERM='xterm-256color'
export PS1='\[\033[01;34m\]\w\[\033[00;35m\]$(__git_ps1 " (%s)")\[\033[01;34m\] $\[\033[00m\] '
export EDITOR=`which vim`

# Bash competion
if [ -f ~/git-completion.bash ]; then
  source ~/git-completion.bash
fi

# Load includes
source ~/.aliases

# Load super secret local configuration
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

# Set the name of the current tmux window to the current
# directory if in a git repo, otherwise restore the automatic-rename option
muxwin() {
  repo=$(git rev-parse --show-toplevel 2> /dev/null)
  if [[ -n "$TMUX" && -n "$repo" ]]; then
    tmux rename-window $(basename $repo)
  elif [[ -n "$TMUX" ]]; then
    tmux set-window-option -q automatic-rename on
  fi
};
export PROMPT_COMMAND=muxwin;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh
