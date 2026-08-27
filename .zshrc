# vim:ft=zsh:set ts=2 sw=2:

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

autoload -Uz compinit
compinit

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	export ZSH_PREFIX="/usr/share"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	export ZSH_PREFIX="/usr/local/share"
fi

# source plugins — prefer system share dirs, fall back to $HOME/.zsh clones
if [[ -d "$ZSH_PREFIX/zsh-autosuggestions" ]]; then
  source $ZSH_PREFIX/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $ZSH_PREFIX/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  fpath+=$ZSH_PREFIX/zsh-completions
else
  source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

[[ -f "$HOME/.zsh/util/config" ]] && source "$HOME/.zsh/util/config"
[[ -f "$HOME/.zsh/util/kitty" ]] && source "$HOME/.zsh/util/kitty"

# shell bindings
#bindkey "set show-all-if-ambiguous on"
#bindkey "TAB:menu-complete"

# path modifications needed by files in .zshrc.d/*
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
export PATH=/usr/local/bin:$PATH

[[ -f "$HOME/.zsh/util/llm-gateway" ]] && source "$HOME/.zsh/util/llm-gateway"

# source config
if [ -d "$HOME/.zshrc.d" ]; then
  for file in "$HOME"/.zshrc.d/*; do
    [ -f $file ] && source $file
  done
fi

zstyle ':completion:*' menu select

fpath+=~/.zfunc

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
else
  fpath=($HOME/.zsh/zsh-completions/src $fpath)
fi

[[ -d "$HOME/.zsh/completions" ]] && fpath=($HOME/.zsh/completions $fpath)

eval "$(mise activate bash)"

[[ -d "/opt/clio/bin/devxp" ]] && export PATH="/opt/clio/bin/devxp:$PATH"
