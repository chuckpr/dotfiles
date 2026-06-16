# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Personal dotfiles repository for managing development environment configurations using **GNU Stow** for symlink deployment. Configurations target `~/.config/` following XDG Base Directory standards.

## Architecture Overview

This is an **integrated terminal development environment** with:
- **Terminal Stack**: Wezterm (emulator) → Starship (prompt) → Tmux (multiplexer) → Sesh (session manager)
- **Editor**: LazyVim (Neovim) with 150+ plugins, AI integration via CodeCompanion
- **Command History**: Atuin with cloud sync and secret filtering
- **Unified Theme**: Gruvbox Dark across all tools
- **Shell**: Fish (`/usr/local/bin/fish`)

### Key Integration Points

1. **Tmux ↔ Sesh**: `Ctrl+b` + `b` opens session picker popup
2. **Sesh → LazyVim**: Dotfiles session auto-opens Neovim with git file picker
3. **Sesh → Jupyter**: Data730 session runs `pixi run jupyter lab`
4. **LazyVim ↔ CodeCompanion**: AI assistant with Claude Opus 4.5, inline chat, command execution
5. **Color Consistency**: Gruvbox Dark theme shared across Wezterm, Tmux, and LazyVim

## Configuration Structure

Each stow package follows the pattern `<package>/<config-dir>/files` so that stow creates `~/.config/<config-dir>/` symlinks. The `lazyvim` package uses `NVIM_APPNAME=lazyvim` so Neovim reads `~/.config/lazyvim/` instead of the default `~/.config/nvim/`.

```
dotfiles/
├── .stowrc                        # Stow config: --target=~/.config, --ignore=atuin/*
├── lazyvim/lazyvim/               # → ~/.config/lazyvim/ (requires NVIM_APPNAME=lazyvim)
│   ├── init.lua                   # Entry point, loads config.lazy
│   ├── lazy-lock.json             # Locked plugin versions
│   ├── lazyvim.json               # Enabled LazyVim extras
│   ├── lua/config/                # Core config (lazy.lua, keymaps.lua, options.lua)
│   └── lua/plugins/               # Custom plugin specs (codecompanion, colorscheme, etc.)
├── tmux/tmux/tmux.conf            # → ~/.config/tmux/tmux.conf
├── sesh/sesh/sesh.toml            # → ~/.config/sesh/sesh.toml
├── wezterm/wezterm/wezterm.lua    # → ~/.config/wezterm/wezterm.lua
├── starship/starship/starship.toml  # → ~/.config/starship/starship.toml
└── atuin/config.toml              # Command history (NOT stow-managed, uses ~/.local/share/)
```

## Common Commands

### Deployment
```bash
# Deploy configurations (from dotfiles directory)
stow lazyvim    # → ~/.config/lazyvim  (requires NVIM_APPNAME=lazyvim in fish config)
stow tmux       # → ~/.config/tmux
stow wezterm    # → ~/.config/wezterm
stow starship   # → ~/.config/starship
stow sesh       # → ~/.config/sesh

# Remove/unstow
stow -D lazyvim
```

**Note**: Atuin is NOT managed by Stow (excluded in `.stowrc`). Config lives at `~/.local/share/atuin/config.toml`.

### LazyVim Development

**Plugin Management**:
```bash
# Inside Neovim
:Lazy                    # Open Lazy plugin manager
:Lazy sync               # Update all plugins
:Lazy restore            # Restore from lazy-lock.json
:Lazy clean              # Remove unused plugins
```

**Testing Plugin Changes**:
```lua
-- Add to lua/plugins/test.lua
return {
  "author/plugin-name",
  opts = { ... },
  config = function(_, opts)
    require("plugin-name").setup(opts)
  end,
}
```

**Checking LazyVim Extras**:
```bash
# Inside Neovim
:LazyExtras             # Browse available extras
```

**Lua Formatting**:
```bash
stylua lua/            # Format Lua files (config in stylua.toml)
```

### Tmux Plugin Management

```bash
# Inside Tmux
<prefix> + I           # Install TPM plugins (Ctrl+b then I)
<prefix> + U           # Update plugins
<prefix> + alt+u       # Uninstall removed plugins
```

### Sesh Session Management

```bash
# Command line
sesh connect dotfiles   # Connect to Dotfiles session
sesh list              # List all sessions

# Inside Tmux
Ctrl+b + b             # Open session picker (via gum filter)
```

## LazyVim Plugin Architecture

### Core Plugin Categories

1. **AI Integration** (`codecompanion.lua`):
   - Model: Claude Opus 4.5 (via Anthropic API or AWS Bedrock)
   - Keybindings: `<C-a>` prefix for actions, `;;` abbreviation for inline chat
   - History: `~/.local/share/codecompanion-history/`
   - Dependencies: `render-markdown.nvim`, `snacks.nvim`

2. **UI Enhancements**:
   - `which-key.lua`: Helix-style keymap preset
   - `mini-diff.lua`: Inline git diff signs
   - `render-markdown.lua`: Enhanced markdown in chat/notes

3. **Language Support** (`lazyvim.json` extras):
   - Python, TypeScript, JSON, TOML formatters/LSPs
   - `jupytext.lua`: Edit `.ipynb` files as `.py` with Jupytext

4. **Theme** (`colorscheme.lua`):
   - Gruvbox Dark (`ellisonleao/gruvbox.nvim`)
   - Must match Wezterm/Tmux theme for consistency

### Plugin Patterns

**Lazy-loading**:
```lua
return {
  "plugin/name",
  event = "VeryLazy",  -- Load on first input after startup
  keys = { ... },      -- Load on keymap trigger
  ft = "python",       -- Load for specific filetype
}
```

**Overriding LazyVim Defaults**:
```lua
-- lua/config/lazy.lua: spec.defaults
spec = {
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  defaults = { lazy = true, version = false },  -- Disable lazy-loading here
}
```

**Disabling Unwanted Plugins**:
```lua
-- In lua/config/lazy.lua
{ "plugin-to-disable", enabled = false }
```

## Sesh Session Configuration

Pre-configured sessions in `sesh.toml`:

| Session | Purpose | Startup Command | Environment |
|---------|---------|----------------|-------------|
| Downloads | File management | `yazi` (file manager) | Default |
| Dotfiles | Config editing | `nvim` + Snacks git picker | Default |
| Data730 | Jupyter notebooks | `pixi run jupyter lab` | Pixi env |
| Blog | Blog writing | Git worktree | Default |
| Active Learning | ML project | Pixi environment | Pixi env |

**Adding New Sessions**:
```toml
[[session]]
name = "myproject"
path = "/Users/cpepe-ranney/projects/myproject"
startup_command = "nvim"
startup_script = """
tmux send-keys 'git status' Enter
tmux split-window -h
"""
```

## Tmux Configuration Details

**Key Customizations** (`tmux.conf`):
- Window indexing starts at 1 (not 0)
- Vi keybinds in copy mode
- True color support (256 colors)
- Default shell: `/usr/local/bin/fish`
- Sesh popup: `bind-key "b" display-popup -E -w 40% "sesh connect"`

**TPM Plugins**:
1. `tmux-plugins/tmux-sensible` - Sensible defaults
2. `fzf-tmux-pane-switch` - Fuzzy pane switching
3. `tmux-gruvbox` - Gruvbox theme
4. `tmux-battery` - Battery indicator in status bar

## Atuin Configuration

**Location**: `~/.local/share/atuin/config.toml` (NOT `~/.config/`)

**Key Settings**:
- UI style: Full (not compact)
- Enter behavior: Manual edit (no auto-accept)
- Sync: Version 2 protocol enabled
- Secret filtering: Enabled for AWS keys, GitHub PATs, Slack tokens, Stripe keys

## Important Notes

### Git Configuration
- **Main branch**: `main` (local development branch)
- **Default upstream**: `master` (for PRs)
- Always create PRs targeting `master`, not `main`

### Stow Behavior
- `.stowrc` targets `~/.config/` by default
- Atuin explicitly excluded from Stow (uses `~/.local/share/`)
- Ignores: `.DS_Store`, `.stowrc`, `atuin/*`

### LazyVim Extras
8 extras currently enabled (see `lazyvim.json`):
- `coding.mini-surround`
- `editor.fzf`, `editor.mini-files`, `editor.snacks_picker`, `editor.telescope`
- `lang.toml`
- `ui.indent-blankline`, `ui.mini-animate`

Do not enable extras that conflict with existing plugins or keybindings.

### Color Scheme Consistency
When modifying themes:
1. Update Wezterm (`wezterm.lua`: `color_scheme`)
2. Update Tmux (`tmux.conf`: TPM gruvbox plugin or manual colors)
3. Update LazyVim (`lua/plugins/colorscheme.lua`)

All three must match for visual consistency.
