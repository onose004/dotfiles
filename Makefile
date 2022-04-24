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
	mkdir -p $(HOME)/.config/coc $(HOME)/.config/nvim $(HOME)/.config/nayvy; \
	ln -fs $(HOME)/dotfiles/ultisnips $(HOME)/.config/coc/ultisnips; \
	ln -fs $(HOME)/dotfiles/.vimrc $(HOME)/.config/nvim/init.vim; \
  ln -fs $(HOME)/dotfiles/.vim/coc-settings.json $(HOME)/.config/nvim \
  ln -fs $(HOME)/dotfiles/import_config.nayvy $(HOME)/.config/nayvy


clean: ## Remove the dot files
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)

update:
	@DOTPATH=$(DOTPATH) /bin/bash $(DOTPATH)/etc/update.sh

test:
	@DOTPATH=$(DOTPATH) bats "$(DOTPATH)/tests"
