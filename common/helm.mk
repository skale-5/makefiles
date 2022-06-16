# ====================================
# H E L M
# ====================================

##@ Helm

.PHONY: helm-deps
helm-deps: guard-SERVICE ## Install Helm chart dependencies (SERVICE=xxx)
	@source $(SERVICE)/chart.sh && \
		if [[ $$CHART_REPO_URL != https://* ]]; then \
			mkdir -p $(SERVICE)/charts/ && \
			tar -czf $(SERVICE)/charts/$$CHART_REPO_NAME-$$CHART_VERSION.tgz --directory=$$CHART_REPO_URL . ; \
		else \
			([ ! -f "$(SERVICE)/Chart.yaml" ] && \
			helm repo add $$CHART_REPO_NAME $$CHART_REPO_URL && \
			helm repo update) || \
			([ -f "$(SERVICE)/Chart.yaml" ] && \
			helm dependency update $(SERVICE) || \
			echo "No dependencies found."); \
		fi

.PHONY: helm-values
helm-values: guard-SERVICE ## Show Helm values for the selected service (SERVICE=xxx)
	@source $(SERVICE)/chart.sh && \
		if [[ $$CHART_REPO_URL != https://* ]]; then \
			helm show values $$CHART_REPO_URL; \
		else \
			if [ ! -n "$(SKIP_DEPS)" ]; then \
				echo -e "I will pull deps for you, next time you can use SKIP_DEPS=true "; \
				([ ! -f "$(SERVICE)/Chart.yaml" ] && \
				helm repo add $$CHART_REPO_NAME $$CHART_REPO_URL && \
				helm repo update) || \
				([ -f "$(SERVICE)/Chart.yaml" ] && \
				helm dependency update $(SERVICE) || \
				echo "No dependencies found."); \
			fi; \
			helm show values $$CHART_REPO_NAME/$$CHART_NAME; \
		fi

.PHONY: helm-template
helm-template: guard-SERVICE guard-ENV ## Render chart templates locally and display the output. (SERVICE=xxx ENV=xxx)
	@source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		source sk5-scripts/merge-charts.sh $(SERVICE) $(ENV) && \
		helm template $$CHART_NAME $$CHART_PATH \
		--namespace $$CHART_NAMESPACE -f $$FILE \
		--version $$CHART_VERSION

.PHONY: helm-validate
helm-validate: guard-SERVICE guard-ENV kubernetes-check-context ## Simulate the installation/upgrade of a release (SERVICE=xxx ENV=xxx)
	@source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		source sk5-scripts/merge-charts.sh $(SERVICE) $(ENV) && \
		helm upgrade --install $$CHART_NAME $$CHART_PATH \
		--namespace $$CHART_NAMESPACE -f $$FILE \
		--version $$CHART_VERSION --create-namespace --dry-run

.PHONY: helm-diff
helm-diff: guard-SERVICE guard-ENV kubernetes-check-context ## Show diff of an installation/upgrade of the release (SERVICE=xxx ENV=xxx)
	@source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		source sk5-scripts/merge-charts.sh $(SERVICE) $(ENV) && \
		helm diff upgrade --install $$CHART_NAME $$CHART_PATH \
		--namespace $$CHART_NAMESPACE -f $$FILE \
		--version $$CHART_VERSION

.PHONY: helm-install
helm-install: guard-SERVICE guard-ENV kubernetes-check-context ## Install/Upgrade the release (SERVICE=xxx ENV=xxx)
	@source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		source sk5-scripts/merge-charts.sh $(SERVICE) $(ENV) && \
		helm upgrade --install $$CHART_NAME $$CHART_PATH \
		--namespace $$CHART_NAMESPACE -f $$FILE \
		--version $$CHART_VERSION --create-namespace

.PHONY: helm-uninstall
helm-uninstall: guard-SERVICE guard-ENV kubernetes-check-context ## Uninstall the release (SERVICE=xxx ENV=xxx)
	@source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		helm uninstall $$CHART_NAME --namespace $$CHART_NAMESPACE