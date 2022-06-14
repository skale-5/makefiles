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

.PHONY: cookiecutter-create
cookiecutter-create: ## Create a new environment using Cookiecutter
	@echo -e "$(OK_COLOR)[$(BANNER)] Create environment$(NO_COLOR)"
	@./sk5-scripts/cookiecutter-add-env.sh