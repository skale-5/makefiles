# ====================================
# H E L M
# ====================================

##@ Helm

.PHONY: helm-deps
helm-deps: guard-SERVICE ## Install Helm chart dependencies (SERVICE=xxx)
	@source $(SERVICE)/chart.sh && \
		([ ! -f "$(SERVICE)/Chart.yaml" ] && \
		helm repo add $$CHART_REPO_NAME $$CHART_REPO_URL && \
		helm repo update) || \
		([ -f "$(SERVICE)/Chart.yaml" ] && \
		helm dependency update $(SERVICE) || \
		echo "No dependencies found."); \


.PHONY: helm-values
helm-values: guard-SERVICE ## Show Helm values for the selected service (SERVICE=xxx)
	@source $(SERVICE)/chart.sh && \
		if [ ! -n "$(SKIP_DEPS)" ]; then \
			echo -e "I will pull deps for you, next time you can use SKIP_DEPS=true "; \
			([ ! -f "$(SERVICE)/Chart.yaml" ] && \
			helm repo add $$CHART_REPO_NAME $$CHART_REPO_URL && \
			helm repo update) || \
			([ -f "$(SERVICE)/Chart.yaml" ] && \
			helm dependency update $(SERVICE) || \
			echo "No dependencies found."); \
		fi; \
		helm show values $${CHART_PATH:-$$CHART_REPO_NAME/$$CHART_NAME}

.PHONY: helm-template
helm-template: guard-SERVICE guard-ENV ## Render chart templates locally and display the output. (SERVICE=xxx ENV=xxx)
	@source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		helm template $${CHART_RELEASE_NAME:-$(CHART_PATH\#\#\*/)} $${CHART_PATH:-$$CHART_REPO_NAME/$$CHART_NAME} \
		--namespace $$CHART_NAMESPACE -f $(SERVICE)/values/$(ENV)/values.yaml \
		--version $$CHART_VERSION

.PHONY: helm-validate
helm-validate: guard-SERVICE guard-ENV kubernetes-check-context ## Simulate the installation/upgrade of a release (SERVICE=xxx ENV=xxx)
	@source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		helm upgrade --install $${CHART_RELEASE_NAME:-$(CHART_PATH\#\#\*/)} $${CHART_PATH:-$$CHART_REPO_NAME/$$CHART_NAME} \
		--namespace $$CHART_NAMESPACE -f $(SERVICE)/values/$(ENV)/values.yaml \
		--version $$CHART_VERSION --create-namespace --dry-run

.PHONY: helm-diff
helm-diff: guard-SERVICE guard-ENV kubernetes-check-context ## Show diff of an installation/upgrade of the release (SERVICE=xxx ENV=xxx)
	@source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		helm diff upgrade --install $${CHART_RELEASE_NAME:-$(CHART_PATH\#\#\*/)} $${CHART_PATH:-$$CHART_REPO_NAME/$$CHART_NAME} \
		--namespace $$CHART_NAMESPACE -f $(SERVICE)/values/$(ENV)/values.yaml \
		--version $$CHART_VERSION

.PHONY: helm-install
helm-install: guard-SERVICE guard-ENV kubernetes-check-context ## Install/Upgrade the release (SERVICE=xxx ENV=xxx)
	@source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		helm upgrade --install $${CHART_RELEASE_NAME:-$(CHART_PATH\#\#\*/)} $${CHART_PATH:-$$CHART_REPO_NAME/$$CHART_NAME} \
		--namespace $$CHART_NAMESPACE -f $(SERVICE)/values/$(ENV)/values.yaml \
		--version $$CHART_VERSION --create-namespace

.PHONY: helm-uninstall
helm-uninstall: guard-SERVICE guard-ENV kubernetes-check-context ## Uninstall the release (SERVICE=xxx ENV=xxx)
	@source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		helm uninstall $${CHART_RELEASE_NAME:-$(CHART_PATH\#\#\*/)} --namespace $$CHART_NAMESPACE
