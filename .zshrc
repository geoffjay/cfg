# vim:ft=zsh:set ts=2 sw=2:

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# shell bindings
#bindkey "set show-all-if-ambiguous on"
#bindkey "TAB:menu-complete"

[[ -f "$HOME/.zsh/util/path" ]] && source "$HOME/.zsh/util/path"
[[ -f "$HOME/.zsh/util/plugins" ]] && source "$HOME/.zsh/util/plugins"
[[ -f "$HOME/.zsh/util/kitty" ]] && source "$HOME/.zsh/util/kitty"
[[ -f "$HOME/.zsh/util/llm-gateway" ]] && source "$HOME/.zsh/util/llm-gateway"

# source config
if [ -d "$HOME/.zshrc.d" ]; then
  for file in "$HOME"/.zshrc.d/*; do
    [ -f $file ] && source $file
  done
fi

[[ -f "$HOME/.zsh/util/config" ]] && source "$HOME/.zsh/util/config"
[[ -f "$HOME/.zsh/util/clio" ]] && source "$HOME/.zsh/util/clio"
