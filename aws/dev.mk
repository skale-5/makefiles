# ====================================
# D E V E L O P M E N T
# ====================================

##@ Development

.PHONY: clean
clean: ## Cleanup
	@echo -e "$(OK_COLOR)[$(BANNER)] Cleanup$(NO_COLOR)"
	@find . -name "*.retry"|xargs rm -f

.PHONY: check
check: check-terraform check-kubectl check-kustomize check-conftest check-kubeval check-popeye check-tfsec check-tflint check-terraform-docs check-pre-commit check-yq
## Check requirements

