# ====== Clio LLM Gateway (managed by `dev`) ======
# Routes Claude through Clio's LLM gateway by setting ANTHROPIC_BASE_URL and
# ANTHROPIC_AUTH_TOKEN from the local token file.
#
#   Gateway: https://llm-gateway.clio.systems/
#   Help:    #pt-llm-gateway on Slack
#   Refresh: `dev login --force`
#
# Edits to this block will be overwritten.
__clio_llm_gateway_token_path="$HOME/.clio/llm-gateway-token"
if [ -f "$__clio_llm_gateway_token_path" ]; then
  export ANTHROPIC_BASE_URL="${LLM_GATEWAY_URL:-https://llm-gateway.clio.systems}"
  export ANTHROPIC_AUTH_TOKEN="$(cat "$__clio_llm_gateway_token_path")"
  export ANTHROPIC_API_KEY="$(cat "$__clio_llm_gateway_token_path")"
  # variables needed for pi
  export CLAUDE_CODE_USE_FOUNDRY=1
  export FOUNDRY_BASE_URL="https://llm-gateway.clio.systems"
  export ANTHROPIC_FOUNDRY_API_KEY="$(cat "$__clio_llm_gateway_token_path")"
fi
unset __clio_llm_gateway_token_path

# Avoid loading all tools into context. True is the default, except
# ANTHROPIC_BASE_URL switches the default to false
export ENABLE_TOOL_SEARCH=true
# ====== End Clio LLM Gateway ======

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

# shell bindings
#bindkey "set show-all-if-ambiguous on"
#bindkey "TAB:menu-complete"

# direnv hook
if [[ -x $(which direnv) ]]; then
  eval "$(direnv hook zsh)"
fi

export INITIAL_PATH=$PATH

if [[ -n "$DEBUG" ]]; then
  echo "--------- initial ----------"
  echo $INITIAL_PATH
  echo -e "-----------------------------\n"
fi

# path modifications needed by files in .zshrc.d/*
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

# add completions from zsh-completions and other custom ones
fpath=($HOME/.zsh/zsh-completions/src $fpath)
fpath=($HOME/.zsh/completions $fpath)

eval "$(dev _hook)"
eval "$(mise activate bash)"

[[ -d "/opt/clio/bin/devxp" ]] && export PATH="/opt/clio/bin/devxp:$PATH"

[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# Added by cua-driver-rs installer — see https://github.com/trycua/cua
export PATH="/Users/geoff/.local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
