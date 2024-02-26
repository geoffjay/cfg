# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/geoff/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/geoff/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/geoff/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/geoff/.fzf/shell/key-bindings.zsh"
