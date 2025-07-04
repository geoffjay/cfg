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

# source plugins
# - zsh-autosuggestions
# - zsh-completions
# - zsh-syntax-highlighting

source $ZSH_PREFIX/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PREFIX/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fpath+=$ZSH_PREFIX/zsh-completions

# configuration is managed through git with an alias to set the working directory
export CFGDIR=$HOME/.cfg
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias cfg="config"

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
if [[ -x $(which direnv) ]]; then
  eval "$(direnv hook zsh)"
fi

# dev hook
if [[ -x $(which dev) ]]; then
	eval "$(dev _env)";
	eval "$(dev _hook)"
fi

# path
export PATH="$HOME/.local/bin:$PATH"
export PATH=/usr/local/bin:$PATH

# source config
if [ -d "$HOME/.zshrc.d" ]; then
  for file in "$HOME"/.zshrc.d/*; do
    [ -f $file ] && source $file
  done
fi

zstyle ':completion:*' menu select

fpath+=~/.zfunc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
