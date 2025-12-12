# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository built on top of [dotly](https://github.com/CodelyTV/dotly), a dotfiles framework that creates an opinionated structure for managing shell configurations, scripts, and symlinks. The repository includes both public dotly modules and private configurations stored in the `modules/private` submodule.

## Architecture

### Core Components

- **dotly framework** (`modules/dotly/`): Git submodule providing the core dotfiles framework
- **private module** (`modules/private/`): Git submodule with private/work-specific configurations
- **Shell initialization**: Uses a layered approach sourcing configurations from `shell/init.sh`:
  - `shell/aliases.sh` → `shell/private-aliases.sh`
  - `shell/exports.sh` → `shell/private-exports.sh`
  - `shell/functions.sh` → `shell/private-functions.sh`

### Directory Structure

```
├── bin/                      # Custom binaries (sdot wrapper)
├── editors/                  # VS Code, Sublime, Vim configs
├── git/                      # Git configuration with conditional includes
├── langs/                    # Language-specific configs (Java, JS, PHP, Python)
├── modules/
│   ├── dotly/               # Core dotly framework (submodule)
│   └── private/             # Private configurations (submodule)
├── os/
│   ├── mac/                 # macOS-specific configs (Raycast scripts, Chrome extensions)
│   └── linux/               # Linux-specific configs
├── restoration_scripts/     # Scripts to run when restoring dotfiles
├── scripts/                 # Custom scripts organized by context
│   ├── docker/
│   ├── git/
│   ├── mac/
│   ├── private/
│   ├── system/
│   └── utils/
├── shell/                   # Shell configuration files
│   ├── bash/
│   ├── zsh/
│   ├── aliases.sh
│   ├── exports.sh
│   ├── functions.sh
│   ├── init.sh             # Main shell initialization file
│   └── private-*.sh        # Private versions (gitignored)
└── symlinks/               # Dotbot symlink configurations
    ├── conf.yaml           # Base symlinks
    ├── conf.macos.yaml     # macOS-specific
    └── conf.linux.yaml     # Linux-specific
```

## Common Commands

### Dotfiles Management

```bash
# Main command interface - shows all available scripts
dot

# Show available scripts in a context
dot <context>

# Run a specific script
dot <context> <script> [args]

# Install/restore dotfiles
dot self install

# Update dotly framework
dot self update

# Debug dotly issues
dot self debug

# Lint dotly bash files
dot self lint
```

### Package Management

```bash
# Install packages from previously dumped list
dot package import

# Dump all installed packages to version control
dot package dump

# Update all packages across all package managers
dot package update_all
# Or use alias:
up
```

### Git Operations

```bash
# Commit with all files added
dot git commit

# Pretty diff viewer with fzf
dot git pretty-diff
# Or use alias:
gd

# Pretty log viewer
dot git pretty-log
# Or use alias:
gl

# Amend commit
dot git amend

# Remove file from history completely
dot git rm-file-history

# Apply .gitignore to already committed files
dot git apply-gitignore

# Show changed files compared to main
dot git changed-files

# Find commits by message
dot git find

# List contributors
dot git contributors
```

### Symlink Management

```bash
# Apply all symlinks defined in symlinks/conf*.yaml
dot symlinks apply
```

### Custom Scripts

Custom scripts are located in `scripts/` and organized by context:
- `docker/*`: Container management scripts
- `git/*`: Git workflow helpers
- `mac/*`: macOS-specific utilities
- `system/*`: System utilities
- `utils/*`: General utilities
- `private/*`: Private/work-specific scripts

## Git Configuration

The `.gitconfig` uses conditional includes to support multiple Git identities:

- Personal projects: `~/Code/mine/` → `.gitconfig-mine`
- Dotfiles repo: `~/.dotfiles/` → `.gitconfig-mine`
- Work projects: `~/Code/Adevinta/` → `modules/private/git/.gitconfig-adevinta`

When modifying git configs, respect this pattern to maintain separate identities.

## Symlinks System

Symlinks are managed via dotbot configuration files in `symlinks/`:
- `conf.yaml`: Base configuration for all platforms
- `conf.macos.yaml`: macOS-specific symlinks
- `conf.linux.yaml`: Linux-specific symlinks

To version a new config file:
1. Copy it to the appropriate location in dotfiles (e.g., `editors/code/settings.json`)
2. Add symlink entry to the appropriate `conf*.yaml` file
3. Run `dot symlinks apply`

## Shell Environment

### Theme Configuration

The repository uses the Codely theme (built into dotly). Configure via exports in `shell/exports.sh`:
- `CODELY_THEME_MINIMAL`: Minimal vs full prompt
- `CODELY_THEME_MODE`: "dark" or "light"
- `CODELY_THEME_PROMPT_IN_NEW_LINE`: Newline before prompt
- `CODELY_THEME_PWD_MODE`: "short", "full", or "home_relative"

### Key Aliases

See `shell/aliases.sh` for all aliases. Most used:
- `..` / `...`: Navigate up directories
- `ll` / `la`: Enhanced ls with eza
- `dotfiles`: cd to dotfiles directory
- Git shortcuts: `gaa`, `gc`, `gco`, `gs`, `gpl`, `gps`, etc.
- `i.` / `c.` / `o.`: Open current dir in IntelliJ/Code/Finder
- `up`: Update all packages

### Key Functions

See `shell/functions.sh`:
- `cdd()`: Fuzzy find and cd to subdirectory
- `j()`: Jump to frequently used directories (using z)
- `recent_dirs()`: Fuzzy find from recent directory history

## Modifying This Repository

### Adding New Scripts

1. Create script in `scripts/<context>/<script_name>`
2. Make it executable: `chmod +x scripts/<context>/<script_name>`
3. Use it via: `dot <context> <script_name>`

### Adding New Aliases/Functions

- Public: Edit `shell/aliases.sh` or `shell/functions.sh`
- Private: Edit `shell/private-aliases.sh` or `shell/private-functions.sh`

### Working with Submodules

```bash
# Update dotly framework
cd modules/dotly && git pull origin main && cd ../..
git add modules/dotly
git commit -m "Update dotly framework"

# Initialize submodules when cloning
git submodule update --init --recursive modules/dotly
```

### Private Module

The `modules/private` submodule contains work-specific configurations. It's referenced but may not be accessible. When making changes that should be public, ensure they're in the main repository, not the private module.

## Important Notes

- The `sdot` wrapper in `bin/sdot` sources the shell environment before running `dot` commands
- PATH priority is managed in `shell/exports.sh` with highest priority first
- The repository supports both Bash and Zsh through shared initialization via `shell/init.sh`
- Restoration scripts in `restoration_scripts/` run during dotfiles installation on new machines
- Delta is configured as the git pager for improved diff viewing
- The repository uses multiple package managers: Homebrew, Cargo, npm, pip, gem, mas (Mac App Store)
