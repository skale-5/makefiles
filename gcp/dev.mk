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
	@cookiecutter git@git.sk5.io:skale-5/cookiecutter/cookiecutter-gcp/cookiecutter-gcp-project.git --output-dir tmp/

.PHONY: cicd-generator
cicd-generator: ## Regen CI using CICD generator
	@mkdir -p ../tmp/ && \
	[ ! -d ../tmp/cicd-generator ] && git clone git@git.sk5.io:skale-5/cicd-generator.git ../tmp/cicd-generator || (cd ../tmp/cicd-generator && git pull) && \
	cd ../tmp/cicd-generator && \
	{ [ -f clients/$(CUSTOMER).yaml ] && make generate VARS=clients/$(CUSTOMER).yaml PROJECT=$(DIR); } || \
	{ [ -f clients/$(CUSTOMER).yml  ] && make generate VARS=clients/$(CUSTOMER).yml  PROJECT=$(DIR); }
