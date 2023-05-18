# Config Files

## Setup

Configuration is managed using an alias to `git` that's setup by adding the
lines:

```shell
export CFGDIR=$HOME/.cfg/
alias config="/usr/bin/git --git-dir=$CFGDIR --work-tree=$HOME"
```

to `.bashrc` or `.zshrc` and source in the shell to make active. Afterwards,
the command `config` is used to alias all typical `git` usage.

To pull configuration and backup any existing files

```shell
git clone --bare https://github.com/geoffjay/cfg.git $HOME/.cfg
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "checked out config";
else
  echo "backing up pre-existing dot files";
  config checkout 2>&1 |\
    egrep "\s+\." |\
    awk {'print $1'} |\
    xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
```

## tmux

Install tpm with:

```shell
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

the other plugins are installed through `.tmux.conf`.

## neovim

See https://github.com/geoffjay/astronvim-user.
