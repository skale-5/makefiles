# ====================================
# T E R R A F O R M
# ====================================

##@ Terraform

.PHONY: terraform-show
terraform-show: guard-SERVICE guard-ENV ## Show infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Show infrastructure$(NO_COLOR)"
	@cd $(SERVICE)/terraform \
		&& terraform init -reconfigure -backend-config=backend-vars/$(ENV).tfvars \
		&& terraform show

.PHONY: terraform-plan
terraform-plan: guard-SERVICE guard-ENV ## Plan infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Plan infrastructure$(NO_COLOR)"
	cd $(SERVICE)/terraform \
		&& terraform init -reconfigure -backend-config=backend-vars/$(ENV).tfvars \
		&& terraform plan -lock-timeout=60s -var-file=tfvars/$(ENV).tfvars

.PHONY: terraform-apply
terraform-apply: guard-SERVICE guard-ENV ## Builds or changes infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Apply infrastructure$(NO_COLOR)"
	@cd $(SERVICE)/terraform \
		&& terraform init -reconfigure -backend-config=backend-vars/$(ENV).tfvars \
		&& terraform apply -lock-timeout=60s -var-file=tfvars/$(ENV).tfvars

.PHONY: terraform-destroy
terraform-destroy: guard-SERVICE guard-ENV ## Builds or changes infrastructure (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Apply infrastructure$(NO_COLOR)"
	@cd $(SERVICE)/terraform \
		&& terraform init -reconfigure -backend-config=backend-vars/$(ENV).tfvars \
		&& terraform destroy -lock-timeout=60s -var-file=tfvars/$(ENV).tfvars

.PHONY: terraform-providers-lock
terraform-providers-lock: guard-SERVICE guard-ENV ## Providers lock (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Apply infrastructure$(NO_COLOR)"
	@cd $(SERVICE)/terraform \
		&& terraform init -reconfigure -backend-config=backend-vars/$(ENV).tfvars \
		&& terraform providers lock -platform=darwin_amd64 -platform=linux_amd64 -platform=darwin_arm64
