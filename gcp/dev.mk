# ====================================
# D E V E L O P M E N T
# ====================================

##@ Development

.PHONY: clean
clean: ## Cleanup
	@echo -e "$(OK_COLOR)[$(BANNER)] Cleanup$(NO_COLOR)"
	@find . -name "*.retry"|xargs rm -f

.PHONY: check
check: check-terraform check-kubectl check-kustomize check-conftest check-kubeval check-popeye check-tfsec check-tflint check-terraform-docs check-pre-commit check-yq ## Check requirements
	@echo
	@echo BANNER=$(BANNER)
	@echo CUSTOMER=$(CUSTOMER)
	@echo BASTION_NAME=$(BASTION_NAME)
	@echo EXPLOIT_ENV=$(EXPLOIT_ENV)
	@echo BASTION_ZONE=$(BASTION_ZONE)

.PHONY: cookiecutter-create
cookiecutter-create: ## Create a new environment using Cookiecutter
	@echo -e "$(OK_COLOR)[$(BANNER)] Create environment$(NO_COLOR)"
	@cookiecutter git@git.sk5.io:skale-5/cookiecutter/cookiecutter-gcp/cookiecutter-gcp-project.git --output-dir tmp/
