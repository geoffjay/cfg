#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source $HOME/.profile

if [[ -f /etc/bash_completion ]]; then
  . /etc/bash_completion
fi

# [ -f /etc/bash_completion ] && . /etc/bash_completion
# [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

#xhost +local:root > /dev/null 2>&1
#if [[ -z "$DISPLAY" -a $XDG_VTNR -eq 1 ]]; then
#  ssh-agent startx
#fi

complete -cf sudo

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export JAVA_FONTS=/usr/share/fonts/TTF
export EDITOR=/usr/bin/vim
#export TERMINAL=/usr/bin/urxvtc

#export BROWSER=/usr/bin/xdg-open
export BROWSER=

ESC=$'['
END_ESC=m

NOPRINT='\['
END_NOPRINT='\]'

WRAP="$NOPRINT$ESC"
END_WRAP="$END_ESC$END_NOPRINT"

RESET="${WRAP}0${END_WRAP}"
RESET_BG="${WRAP}49${END_WRAP}"

NORMAL="${WRAP}21${END_WRAP}"
BOLD="${WRAP}1${END_WRAP}"

# configuration is managed through git with an alias to set the working directory
export CFGDIR=$HOME/.cfg
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

if [[ -d ~/.bash.d ]]; then
  for i in ~/.bash.d/*; do
    # FIXME: this is dumb, just match [0-9][0-9]* ?
    if [[ ${i: -3} == ".md" ]]; then
      continue
    elif [[ ${i: -10} == ".gitignore" ]]; then
      continue
    elif [[ ${i: -6} == "bashrc" ]]; then
      continue
    elif [[ ${i: -4} == ".git" ]]; then
      continue
    elif [[ ${i: -5} == ".idea" ]]; then
      continue
    fi
    [[ -f "${i}" ]] && source "${i}"
  done
fi

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then
  export KITTY_SHELL_INTEGRATION="enabled"
  source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi
# END_KITTY_SHELL_INTEGRATION

# vim: set ts=2 sw=2:
