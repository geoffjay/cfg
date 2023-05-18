# Config Files

Configuration is managed using an alias to `git` that's setup by adding the
lines:

```shell
export CFGDIR=$HOME/.cfg/
alias config="/usr/bin/git --git-dir=$CFGDIR --work-tree=$HOME"
```

to `.bashrc` or `.zshrc`. Afterwards, the command `config` is used to alias
all typical `git` usage.

## tmux

Install tpm with:

```shell
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

the other plugins are installed through `.tmux.conf`.

## neovim

See https://github.com/geoffjay/astronvim-user.
