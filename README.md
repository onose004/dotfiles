Ryosuke's Dotfiles
===

![](./sample/terminal.png)

## Environment

Scripts are tested on following:

- Ubuntu 16.04
- CentOS 7
- Raspbian Stretch

## Setup

### Pre-installation

Get [Terminal theme](https://github.com/arcticicestudio/nord-terminal-app)
Get [Source Code Pro](https://adobe-fonts.github.io/source-code-pro/)

### Install
```
# apt-get update; apt-get install -y curl
bash -c "$(curl -L https://raw.githubusercontent.com/onose004/dotfiles/master/setup.sh)"

# enable zsh
exec zsh -l
```

### Update

```
cd $HOME/dotfiles
git pull
make update
```

### Test

```
make test
```

## What's included?

### Themes
- [Nord](https://www.nordtheme.com/) for `Terminal.app`, `vim` and `tmux`
- [Source Code Pro](https://adobe-fonts.github.io/source-code-pro/) for font

### Multiplexer
- Tmux 3.0a

### Shell
- `zsh` for shell
- `zprezto` for zsh tweaking
- Local zsh config by adding `$HOME/.zshrc.local`

### Editor
- `vim 8.2`

### Testing
- Testing using `bats`
