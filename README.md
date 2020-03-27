Ryosuke's Dotfiles
===

## Environment

Scripts are tested on following:

- Ubuntu 16.04
- CentOS 7
- Raspbian Stretch

## Pre-installation

Get [Terminal theme](https://github.com/arcticicestudio/nord-terminal-app)

## Setup

```
# apt-get update; apt-get install -y curl
bash -c "$(curl -L https://raw.githubusercontent.com/onose004/dotfiles/master/etc/setup.sh)"

# enable zsh
exec zsh -l
```

## What's included?

### Themes
- [Nord](https://www.nordtheme.com/) for `Terminal.app`, `vim` and `tmux`
- [Source Code Pro](https://adobe-fonts.github.io/source-code-pro/) for font

### Multiplexer
- Tmux

### Shell
- `zsh` for shell
- `zprezto` for zsh tweaking

## Update

```
cd $HOME/dotfiles
git pull
```
