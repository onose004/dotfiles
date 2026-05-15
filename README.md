Ryosuke's Dotfiles
===

My dotfiles growing like bonsai trees.

![](./sample/terminal.png)

## Environment

Scripts are tested on:
ubuntu-20.04, ubuntu-latest, macos-latest

## Setup

### Pre-installation (recommended)

- [Nord Theme](https://github.com/arcticicestudio/nord-terminal-app) for Terminal.app
- [Source Code Pro](https://adobe-fonts.github.io/source-code-pro/) for font

### Install

The following script installs basic part of this dotfiles and their plugins
end-to-end in a clean environment.
It also includes an OS update.

```
# apt-get update; apt-get install -y curl
sudo bash -c "$(curl -L https://raw.githubusercontent.com/onose004/dotfiles/master/setup.sh)"

# enable zsh
exec zsh -l
```

### Update

The update script updates dotfiles and their plugins.
It does not include an OS update.

```
cdot
make update
```

### Docker

```
$ docker-compose build
$ docker run -it dotfiles_onose004-ubuntu-20.04 /bin/zsh
```

## What's included?

### Themes
- [Nord](https://www.nordtheme.com/) for `Terminal.app`, `vim` and `tmux`
- [Source Code Pro](https://adobe-fonts.github.io/source-code-pro/) for font

### Multiplexer
- `tmux`

### Shell
- `zsh` for shell
- `zprezto` for zsh tweaking
- Local zsh config by adding `$HOME/.zshrc.local`

### Editor
- `neovim`

### Utils
- `bats` for testing
- `fzf` for interactive filter

## Repo structure

* `bin/`: custom utility commands
* `etc/`: configuration files and scripts for plugins/utilities/applications
* `tests/`: bats format test scripts
* `sample/`: screenshot images
* `Makefile`: a recipe for script execution
* `README.md`
* `setup.sh`: a script for end-to-end installation
