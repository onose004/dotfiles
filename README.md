# Ryosuke's Dotfiles

My dotfiles growing like bonsai trees.

![](./sample/terminal.png)

## Environment

- Ubuntu 22.04+
- CentOS Stream 9
- macOS (Apple Silicon / Intel)

## Setup

### 1. Clone

```sh
git clone https://github.com/onose004/dotfiles ~/dotfiles
```

### 2. Run setup

Linux は root 権限が必要、macOS は通常ユーザーで実行します（Homebrew が root 実行を拒否するため）。

```sh
# Linux
sudo bash ~/dotfiles/setup.sh

# macOS
bash ~/dotfiles/setup.sh
```

以下が自動で行われます:

- 基本ツールのインストール
  - Linux: `apt-get` / `dnf` で git, tmux, zsh, make, curl, unzip
  - Linux: neovim は公式リリースバイナリを `/usr/local/nvim` に導入 (`etc/install_nvim.sh`)
  - macOS: Homebrew をブートストラップし、`Brewfile` に従って CLI / cask アプリを一括インストール
- macOS 限定: Finder の隠しファイル表示などの defaults 設定 (`etc/macos.sh`)
- dotfiles のシンボリックリンク作成 (`make deploy`)
- プラグイン等のインストール (`make install`)

### 3. Start zsh

```sh
exec zsh -l
```

### Update

```sh
cdot
make update
```

## What's included?

### Theme

- [Nord](https://www.nordtheme.com/) for `vim` and `tmux`
- [Source Code Pro](https://adobe-fonts.github.io/source-code-pro/) for font

### Multiplexer

- `tmux` + [tpm](https://github.com/tmux-plugins/tpm)

### Shell

- `zsh` + [zprezto](https://github.com/sorin-ionescu/prezto)
- Machine-local config: `~/.zshrc.local`

### Editor

- `neovim` + [vim-plug](https://github.com/junegunn/vim-plug)
  - Linux のバージョンは `etc/install_nvim.sh` の `NVIM_VERSION` で固定。上げるときはそこを書き換えて `bash etc/install_nvim.sh` を実行
  - Python は組み込み LSP + [pyright](https://github.com/microsoft/pyright) で定義ジャンプ。キーは VS Code に合わせて `F12` 定義 / `Shift+F12` 参照 / `Ctrl+F12` 実装、戻るのは `Ctrl-o`

### Utils

- `fzf` — fuzzy finder
- `ghq` — repository management
- `bats` — shell testing

## Repo structure

```
dotfiles/
├── bin/          custom utility commands
├── etc/          install / update scripts
├── tests/        bats test scripts
├── sample/       screenshot images
├── Makefile
├── setup.sh      end-to-end setup entry point
└── README.md
```
