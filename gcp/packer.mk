# ====================================
# P A C K E R
# ====================================

##@ Packer

.PHONY: packer-build
packer-build: guard-SERVICE guard-ENV guard-GOOGLE_APPLICATION_CREDENTIALS guard-SSH_BASTION_HOST guard-SSH_BASTION_USERNAME guard-SSH_BASTION_PRIVATE_KEY ## Build image
	@echo -e "$(OK_COLOR)[$(CUSTOMER)] Build image$(NO_COLOR)"
	@cd $(SERVICE)/packer && packer build -force -var-file=vars/$(ENV).json packer.json
