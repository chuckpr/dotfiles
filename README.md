# `dotfiles`

## set up

### Neovim

To set up [Neovim](https://neovim.io/):

```
cd ~
gh repo clone chuckpr/dotfiles && cd dotfiles
stow nvim  # will create simlink for ~/.config/nvim to ~/dotfiles/nvim
```

### Tmux

```
stow tmux
```

### Hyper

```
stow hyper
```

### Claude Code

Manages `~/.claude/settings.json` and `~/.claude/hooks/`. The `projects/`
directory and any externally-maintained skills are intentionally excluded.

To migrate existing config into dotfiles for the first time:

```
bash ~/dotfiles/migrate_claude_to_dotfiles.sh
```

On a fresh machine (after cloning dotfiles):

```
stow --no-folding claude
```

To verify symlinks are in place:

```
cd ~/.claude
find . -maxdepth 2 -type l | xargs -I{} sh -c 'echo "{} -> $(readlink {})"'
```