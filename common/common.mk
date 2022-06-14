DEBUG ?=

SHELL = /bin/bash -o pipefail

DIR = $(shell pwd)

CONFIG_HOME = $(or ${XDG_CONFIG_HOME},${XDG_CONFIG_HOME},${HOME}/.config)

INSPEC_EXEC=PATH=${HOME}/.gem/ruby/2.7.0/bin/:${PATH} inspec exec

NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m
INFO_COLOR=\033[36m
WHITE_COLOR=\033[1m

MAKE_COLOR=\033[33;01m%-20s\033[0m

DARKSTAR = 104.199.20.48

.DEFAULT_GOAL := help

OK=[✅]
KO=[❌]
WARN=[⚠️]


.PHONY: help
help:
	@echo -e "$(OK_COLOR)                  $(BANNER)$(NO_COLOR)"
	@echo "------------------------------------------------------------------"
	@echo ""
	@echo -e "${ERROR_COLOR}Usage${NO_COLOR}: make ${INFO_COLOR}<target>${NO_COLOR}"
	@echo -e "${ERROR_COLOR}Environments${NO_COLOR}: $(ENVS)"
	@awk 'BEGIN {FS = ":.*##"; } /^[a-zA-Z_-]+:.*?##/ { printf "  ${INFO_COLOR}%-25s${NO_COLOR} %s\n", $$1, $$2 } /^##@/ { printf "\n${WHITE_COLOR}%s${NO_COLOR}\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo ""

guard-%:
	@if [ "${${*}}" = "" ]; then \
		echo -e "$(ERROR_COLOR)Environment variable $* not set$(NO_COLOR)"; \
		exit 1; \
	fi

check-%:
	@if $$(hash $* 2> /dev/null); then \
		echo -e "$(OK_COLOR)$(OK)$(NO_COLOR) $*"; \
	else \
		echo -e "$(ERROR_COLOR)$(KO)$(NO_COLOR) $*"; \
	fi

print-%:
	@if [ "${$*}" == "" ]; then \
		echo -e "$(ERROR_COLOR)[KO]$(NO_COLOR) $* = ${$*}"; \
	else \
		echo -e "$(OK_COLOR)[OK]$(NO_COLOR) $* = ${$*}"; \
	fi
