# ====================================
# D I A G R A M S
# ====================================

##@ Diagrams

.PHONY: diagrams-init
diagrams-init: ## Initialize diagrams
	@echo -e "$(OK_COLOR)[$(BANNER)] Install requirements$(NO_COLOR)"
	@test -d $(ANSIBLE_VENV) || python3 -m venv $(ANSIBLE_VENV)
	@. $(ANSIBLE_VENV)/bin/activate && pip3 install diagrams

.PHONY: diagrams-generate
diagrams-generate: guard-CLOUD_PROVIDER ## Generate diagrams
	@. $(ANSIBLE_VENV)/bin/activate \
		&& python3 documentation/diagrams/doc.py --output=png --cloud=$(CLOUD_PROVIDER) \
		&& python3 documentation/diagrams/doc.py --output=svg --cloud=$(CLOUD_PROVIDER) \
		&& mv skale-5_* documentation/assets/
