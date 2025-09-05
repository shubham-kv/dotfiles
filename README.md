
# dotfiles

Use a git bare repositry to clone & update your configuration.

## Cloning this repo

Initialize an empty bare repository:

```bash
git init --bare $HOME/.dotfilesgit
```

Setup an alias to git for later use. Put it in your `.bashrc` or `.zshrc`, etc.

```bash
alias dotfilesgit='/usr/bin/git --git-dir=$HOME/.dotfilesgit/ --work-tree=$HOME'
```

Use the configured alias instead of plain `git` for all git operations for your
this repository.

```bash
dotfilesgit --local status.showUntrackedFiles no
dotfilesgit branch -M main
dotfilesgit remote add origin https://github.com/shubham-kv/dotfiles
```

Backup any needed files before pulling changes from the repo.

```bash
dotfilesgit pull origin main
```

