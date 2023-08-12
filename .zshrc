# vim:ft=zsh:set ts=2 sw=2:

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

autoload -Uz compinit
compinit

# source plugins, install with
#  brew install zsh-autosuggestions
#  brew install zsh-syntax-highlighting
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# configuration is managed through git with an alias to set the working directory
export CFGDIR=$HOME/.cfg
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# shell setup
if test -n "$KITTY_INSTALLATION_DIR"; then
  export KITTY_SHELL_INTEGRATION="enabled"
  autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
  kitty-integration
  unfunction kitty-integration
fi

# setup prompt
eval "$(starship init zsh)"

# shell bindings
#bindkey "set show-all-if-ambiguous on"
#bindkey "TAB:menu-complete"

# direnv hook
eval "$(direnv hook bash)"

# dev hook
eval "$(dev _env)";
eval "$(dev _hook)"

# path
export PATH="$HOME/.local/bin:$PATH"
export PATH=/usr/local/bin:$PATH

# source config
if [ -d "$HOME/.zshrc.d" ]; then
  for file in "$HOME"/.zshrc.d/*; do
    [ -f $file ] && source $file
  done
fi
