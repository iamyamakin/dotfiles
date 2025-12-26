is_terminal = $(shell tty &> /dev/null && echo true || echo false)
tty_escape = $(if $(filter true,$(is_terminal)),$(shell printf "\033[$(1)m"))
tty_mkbold = $(call tty_escape,1;$(1))
tty_bold = $(call tty_mkbold,39)
tty_blue = $(call tty_mkbold,34)
tty_red = $(call tty_mkbold,31)
tty_reset = $(call tty_escape,0)
tty_underline = $(call tty_escape,4;39)

export XDG_BIN_HOME ?= $(HOME)/.local/bin
export XDG_CACHE_HOME ?= $(HOME)/.cache
export XDG_CONFIG_DIRS ?= /etc/xdg
export XDG_CONFIG_HOME ?= $(HOME)/.config
export XDG_DATA_DIRS ?= /usr/local/share/:/usr/share/
export XDG_DATA_HOME ?= $(HOME)/.local/share
export XDG_LIB_HOME ?= $(HOME)/.local/lib
export XDG_STATE_HOME ?= $(HOME)/.local/state

XDG_DIRS := $(XDG_BIN_HOME) $(XDG_CACHE_HOME) $(subst :, , $(XDG_CONFIG_DIRS)) $(XDG_CONFIG_HOME) $(XDG_DATA_HOME) $(XDG_LIB_HOME) $(XDG_STATE_HOME)
XDG_DATA_DIRS_SEPARATED := $(subst :, , $(XDG_DATA_DIRS))

UNAME_S := $(shell uname -s)
UNAME_M := $(shell uname -m)
PARENT_SHELL := $(shell echo $$SHELL)

ifeq ($(UNAME_S), Linux)
	HOMEBREW_PREFIX := /home/linuxbrew/.linuxbrew

	ifeq ($(findstring bash, $(PARENT_SHELL)), bash)
		shell_rcfile := $$HOME/.bashrc
	else ifeq ($(findstring zsh, $(PARENT_SHELL)), zsh)
		shell_rcfile := $(shell echo $${HOME}/.zshrc)
	else
		@echo "$(tty_red)...$(tty_reset) $(tty_bold)Supported only bash or zsh$(tty_reset)"
		exit 1
	endif
else ifeq ($(UNAME_S), Darwin)
	ifeq ($(UNAME_M), arm64)
		HOMEBREW_PREFIX := /opt/homebrew
	else
		HOMEBREW_PREFIX := /usr/local
	endif
	ifeq ($(findstring bash, $(PARENT_SHELL)), bash)
		shell_rcfile := $$HOME/.bash_profile
	else ifeq ($(findstring zsh, $(PARENT_SHELL)), zsh)
		shell_rcfile := $(shell echo $${HOME}/.zprofile)
	else
		@echo "$(tty_red)...$(tty_reset) $(tty_bold)Supported only bash or zsh$(tty_reset)"
		exit 1
	endif
else
	@echo "$(tty_red)...$(tty_reset) $(tty_bold)Supported only macOS$(tty_reset)"
	exit 1
endif

.PHONY: xdg-dirs
xdg-dirs: $(XDG_DIRS) $(XDG_DATA_DIRS_SEPARATED)

$(XDG_DIRS):
	mkdir -p $@

$(XDG_DATA_DIRS_SEPARATED):
	sudo mkdir -p $@

.PHONY: xcode-install
xcode-install: xdg-dirs
ifeq ($(UNAME_S), Darwin)
	@echo "$(tty_blue)---$(tty_reset) $(tty_bold)Checking Xcode installation...$(tty_reset)"
	@if (xcode-select -p &> /dev/null); then \
		echo "$(tty_blue)...$(tty_reset) $(tty_bold)Xcode already installed$(tty_reset)"; \
	else \
		echo "$(tty_bold)Installing Xcode...$(tty_reset)"; \
                xcode-select --install; \
                sudo xcodebuild -license accept; \
		echo "$(tty_blue)...$(tty_reset) $(tty_bold)Xcode installed$(tty_reset)"; \
	fi
endif

HOMEBREW := $(HOMEBREW_PREFIX)/bin/brew

.PHONY: brew-install
brew-install: xcode-install
	@echo "$(tty_blue)---$(tty_reset) $(tty_bold)Checking brew installation...$(tty_reset)"
	@if ((test -x $(HOMEBREW)) && (grep -qs 'eval "$$($(HOMEBREW) shellenv)"' $(shell_rcfile))); then \
		echo "$(tty_blue)...$(tty_reset) $(tty_bold)Brew already installed$(tty_reset)"; \
	else \
		echo "$(tty_bold)Installing brew...$(tty_reset)"; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		touch $(shell_rcfile); \
		echo 'export HOMEBREW_NO_ANALYTICS=1' >> $(shell_rcfile); \
		echo 'eval "$$($(HOMEBREW) shellenv)"' >> $(shell_rcfile); \
		chmod 755 $(HOMEBREW_PREFIX)/share; \
		echo "$(tty_blue)...$(tty_reset) $(tty_bold)Brew installed$(tty_reset)"; \
	fi

PIPX := $(HOMEBREW_PREFIX)/bin/pipx
PYTHON := $(HOMEBREW_PREFIX)/bin/python3.13
POETRY := $(XDG_BIN_HOME)/poetry

.PHONY: poetry-install
poetry-install: brew-install
	@echo "$(tty_blue)---$(tty_reset) $(tty_bold)Checking poetry installation...$(tty_reset)"
	@test -x $(PYTHON) || $(HOMEBREW) install python@3.13
	@test -x $(PIPX) || $(HOMEBREW) install pipx
	@if (test -x $(POETRY)); then \
		echo "$(tty_blue)...$(tty_reset) $(tty_bold)Poetry already installed$(tty_reset)"; \
	else \
		echo "$(tty_bold)Installing poetry...$(tty_reset)"; \
		$(PIPX) install --force poetry==2.1.1; \
		echo "$(tty_blue)...$(tty_reset) $(tty_bold)Poetry installed$(tty_reset)"; \
	fi

.PHONY: poetry-install-dependencies
poetry-install-dependencies: poetry-install
	@echo "$(tty_blue)---$(tty_reset) $(tty_bold)Installing poetry dependencies...$(tty_reset)"
	@$(POETRY) install
	@echo "$(tty_blue)...$(tty_reset) $(tty_bold)Poetry dependencies installed$(tty_reset)"

.PHONY: personal-install
personal-install:
	@$(POETRY) run ansible-playbook \
		-e ansible_python_interpreter=$(PYTHON) \
		-e HOMEBREW_PREFIX=$(HOMEBREW_PREFIX) \
		-e desired_state=present \
		playbooks/personal.yaml -K

.PHONY: install
install: poetry-install-dependencies personal-install
	@echo "$(tty_blue)...$(tty_reset) $(tty_bold)Done$(tty_reset)"

.PHONY: uninstall
uninstall:
	@$(POETRY) run ansible-playbook \
		-e ansible_python_interpreter=$(PYTHON) \
		-e HOMEBREW_PREFIX=$(HOMEBREW_PREFIX) \
		-e desired_state=absent \
		playbooks/personal.yaml -K
	@if (test -x $(HOMEBREW)); then \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"; \
	fi
	@if (grep -qs 'eval "$$($(HOMEBREW) shellenv)"' $(shell_rcfile)); then \
		sed -i '' '/eval $('.."$(HOMEBREW)"..' shellenv)"/d' $(shell_rcfile); \
	fi
	@if (grep -qs 'export HOMEBREW_NO_ANALYTICS=1' $(shell_rcfile)); then \
		sed -i '' '/export HOMEBREW_NO_ANALYTICS=1/d' $(shell_rcfile); \
	fi
	@if (test -d $(HOMEBREW_PREFIX)); then \
		sudo rm -rf $(HOMEBREW_PREFIX); \
	fi
	@if (test -d $(XDG_CACHE_HOME)); then \
		sudo rm -rf $(XDG_CACHE_HOME); \
	fi
	@if (test -d $(XDG_CONFIG_HOME)); then \
		sudo rm -rf $(XDG_CONFIG_HOME); \
	fi
	@if (test -d $(XDG_DATA_HOME)); then \
		sudo rm -rf $(XDG_DATA_HOME); \
	fi
	@if (test -d $(XDG_LIB_HOME)); then \
		sudo rm -rf $(XDG_LIB_HOME); \
	fi
	@if (test -d $(XDG_STATE_HOME)); then \
		sudo rm -rf $(XDG_STATE_HOME); \
	fi
	@echo "$(tty_blue)...$(tty_reset) $(tty_bold)Done$(tty_reset)"

.PHONY: lint
lint:
	@poetry run yamllint .
	@poetry run ansible-lint
