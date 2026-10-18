# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/geoff/.docker/bin"
# End of Docker Desktop section.

#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
  . $HOME/.nix-profile/etc/profile.d/nix.sh
fi
. "$HOME/.cargo/env"

[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.

. "$HOME/.grit/bin/env"
