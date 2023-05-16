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

# source config
if [ -d "$HOME/.zsh.d" ]; then
  for file in "$HOME"/.zsh.d/*; do
    [ -f $file ] && source $file
  done
fi

# TODO: move these into .d files

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# added by Nix installer
if [ -e /Users/geoff/.nix-profile/etc/profile.d/nix.sh ]; then
  . /Users/geoff/.nix-profile/etc/profile.d/nix.sh
fi

if test -n "$KITTY_INSTALLATION_DIR"; then
  export KITTY_SHELL_INTEGRATION="enabled"
  autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
  kitty-integration
  unfunction kitty-integration
fi

test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)

eval "$(dev _env)";
eval "$(dev _hook)"

eval "$(starship init zsh)"
