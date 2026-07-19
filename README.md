# linux-machine

Personal configs and scripts for quickly setting up a dev environment on a new Linux machine.

## Contents

- **`prepare-linux-machine.sh`** — sets up a basic dev environment: build tools, git, curl, wget, vim, zsh + Oh My Zsh (with `zsh-syntax-highlighting` and `zsh-autosuggestions` plugins). Supports `apt-get`, `yum`, `dnf`.
- **`zed/`** — `settings.json` for the [Zed editor](https://zed.dev).
- **`obsidian/`** — config, themes, and plugins for [Obsidian](https://obsidian.md).

## Usage

```bash
sudo bash prepare-linux-machine.sh
```

Then copy the config files to their respective locations (`~/.config/zed/settings.json`, your Obsidian vault, ...).

## Planning to use
- Wezterm

> Personal repo, mainly used to back up and sync configs across machines.
