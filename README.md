everybody hasem, these are mine

Personal shell configuration for macOS. Built around daily work in data, SQL, Python scripting, and Claude Code.

## Structure

```
dotfiles/
├── .zshrc                   # Entry point — PATH, tool init, sources zsh/
├── .gitignore_global        # Global gitignore (DS_Store, venvs, .claude/, etc.)
├── starship.toml            # Prompt config (deuteranopia-friendly color palette)
├── ProDeuteranopia.terminal # Terminal profile (dark red background)
├── .claude/
│   └── settings.local.json  # Claude Code settings
└── zsh/
    ├── aliases.zsh          # Git, shell, editor, and Python aliases
    ├── functions.zsh        # Shell functions and Claude launchers
    └── 6crickets.zsh        # Work-specific commands and scripts
```

I am colorblind so a Deuteranopia-friendly using the Okabe-Ito color palette — blues, oranges, and yellows. No red/green distinctions.

| Element | Color |
|---------|-------|
| Directory | Sky blue `#56B4E9` |
| Git branch | Orange `#E69F00` |
| Git status | Yellow `#F0E442` |
| Python venv | Bluish green `#0072B2` |
| Google Cloud | Muted blue `#0072B2` |
| Prompt (success) | Sky blue `#56B4E9` |
| Prompt (error) | Vermillion `#D55E00` |

## Dependencies

- [starship](https://starship.rs) — prompt (`brew install starship`)
- [conda/miniconda](https://docs.conda.io) — Python environment management
- MySQL 8.0, PostgreSQL 16 — via Homebrew
- Google Cloud SDK
- NVM — Node version management
- Claude Code CLI

## Machine-specific config

Local overrides that aren't committed to git go in `~/.zshrc.local`. Sourced automatically at the end of `.zshrc`.
