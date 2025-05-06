# ====================================
# H E L M
# ====================================

##@ Helm
HELMFILE_FILE := $(shell if [ -f $(SERVICE)/helmfile.yaml.gotmpl ]; then echo "$(SERVICE)/helmfile.yaml.gotmpl"; else echo "$(SERVICE)/helmfile.yaml"; fi)

.PHONY: helm-deps
helm-deps: guard-SERVICE guard-ENV ## Updating Helm chart dependencies (SERVICE=xxx ENV=xxx)
	@helmfile deps -f $(HELMFILE_FILE) -e $(ENV)

.PHONY: helm-template
helm-template: guard-SERVICE guard-ENV ## Render chart templates locally and display the output. (SERVICE=xxx ENV=xxx)
	@helmfile template -f $(HELMFILE_FILE) -e $(ENV) --skip-deps

.PHONY: helm-diff
helm-diff: guard-SERVICE guard-ENV kubernetes-check-context ## Show diff of an installation/upgrade of the release (SERVICE=xxx ENV=xxx)
	@helmfile diff -f $(HELMFILE_FILE) -e $(ENV) --skip-deps

.PHONY: helm-install
helm-install: guard-SERVICE guard-ENV kubernetes-check-context ## Install/Upgrade the release (SERVICE=xxx ENV=xxx)
	@helmfile sync -f $(HELMFILE_FILE) -e $(ENV) --skip-deps

.PHONY: helm-uninstall
helm-uninstall: guard-SERVICE guard-ENV kubernetes-check-context ## Uninstall the release (SERVICE=xxx ENV=xxx)
	@helmfile destroy -f $(HELMFILE_FILE) -e $(ENV) --skip-deps
