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
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

clean: ## Remove the dot files
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)

update:
	@DOTPATH=$(DOTPATH) /bin/bash $(DOTPATH)/etc/update.sh

test:
	@DOTPATH=$(DOTPATH) bats "$(DOTPATH)/tests"
