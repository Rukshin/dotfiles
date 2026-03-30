---
paths:
  - "shell/**/*"
  - "symlinks/**/*"
---

# Dotfiles Shell Configuration Rules

When working in `~/.dotfiles`:

## Shell config changes

- Edit `shell/exports.sh` for environment variables and PATH
- Edit `shell/aliases.sh` for aliases
- Edit `shell/functions.sh` for functions
- Never edit `~/.zshrc`, `~/.bashrc`, or other home directory shell files directly — they are symlinks managed by dotbot
- To restore broken symlinks, run `dot symlinks apply`

## Symlinks

- All symlinks are defined in `symlinks/conf*.yaml` (base, macos, linux)
- To add a new symlink: add the entry to the appropriate yaml file, then run `dot symlinks apply`
- Never use `ln -s` manually for files that should be tracked in dotfiles
