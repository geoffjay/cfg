# vim:ft=zsh:set ts=2 sw=2:

. "$HOME/.cargo/env"

# source env config
if [ -d "$HOME/.zshenv.d" ]; then
  for file in "$HOME"/.zshenv.d/*; do
    [ -f $file ] && source $file
  done
fi
