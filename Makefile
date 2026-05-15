DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git *.bck .*.swp
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

setup: ## Setup environment settings
	@DOTPATH=$(DOTPATH) /bin/bash $(DOTPATH)/setup.sh

install: ## Install plugins/utilities/applications
	@DOTPATH=$(DOTPATH) /bin/bash $(DOTPATH)/etc/install.sh

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy: ## Create symlink to home directory
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)\
	mkdir -p $(HOME)/.config/nvim; \
	ln -fs $(HOME)/dotfiles/.vimrc $(HOME)/.config/nvim/init.vim


clean: ## Remove the dot files
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)

update: ## Pull latest changes and re-deploy
	@git -C $(DOTPATH) pull
	@$(MAKE) deploy
	@$(MAKE) install

fmt: ## Format shell, YAML, JSON, and Markdown files
	shfmt -w -i 2 etc bin setup.sh
	shfmt -w -i 2 -ln bash .bashrc .zshrc
	prettier --write "**/*.{yml,yaml,json,md}"

test:
	@DOTPATH=$(DOTPATH) bats "$(DOTPATH)/tests"

test-docker: ## Run integration tests locally via Docker (simulates CI)
	@bash $(DOTPATH)/etc/verify_dotfiles.sh
