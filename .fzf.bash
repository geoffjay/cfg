# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/geoff/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/geoff/.fzf/bin"
fi

eval "$(fzf --bash)"
