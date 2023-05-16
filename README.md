# dotfiles

These files are managed using an alias to `git` that's setup by adding the lines:

```shell
export CFGDIR=$HOME/.cfg/
alias config="/usr/bin/git --git-dir=$CFGDIR --work-tree=$HOME"
```

to `.bashrc` or `.zshrc`.
