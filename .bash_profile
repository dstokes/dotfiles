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
  if [ -n "$TMUX" ]; then
    if [ "$PWD" != "$LPWD" ]; then LPWD="$PWD"; fi
    if [ -d .git ]; then
      tmux rename-window ${PWD//*\//};
    else
      tmux set-window-option -q automatic-rename on
    fi
  fi
};
export PROMPT_COMMAND=muxwin;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh
