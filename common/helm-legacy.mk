# ====================================
# H E L M / L E G A C Y
# ====================================

##@ Helm Legacy


.PHONY: helm-legacy-template
helm-legacy-template: guard-SERVICE guard-ENV ## Render chart templates locally and display the output. (SERVICE=xxx ENV=xxx)
	@echo "WARNING: You're using a deprecated way of managing Helm charts. Please adapt you code. (https://www.notion.so/skale-5/HELM-Point-du-2022-09-27-7605b4b0e4b94648a607d1283f3bd4cf)" && \
		source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		source makefiles/common/scripts/merge-charts.sh $(SERVICE) $(ENV) && \
		helm template $$CHART_RELEASE_NAME $${CHART_PATH:-$$CHART_REPO_NAME/$$CHART_NAME} \
		--namespace $$CHART_NAMESPACE -f $$FILE \
		--version $$CHART_VERSION

.PHONY: helm-legacy-validate
helm-legacy-validate: guard-SERVICE guard-ENV kubernetes-check-context ## Simulate the installation/upgrade of a release (SERVICE=xxx ENV=xxx)
	@echo "WARNING: You're using a deprecated way of managing Helm charts. Please adapt you code. (https://www.notion.so/skale-5/HELM-Point-du-2022-09-27-7605b4b0e4b94648a607d1283f3bd4cf)" && \
		source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		source makefiles/common/scripts/merge-charts.sh $(SERVICE) $(ENV) && \
		helm upgrade --install $$CHART_RELEASE_NAME $${CHART_PATH:-$$CHART_REPO_NAME/$$CHART_NAME} \
		--namespace $$CHART_NAMESPACE -f $$FILE \
		--version $$CHART_VERSION --create-namespace --dry-run

.PHONY: helm-legacy-diff
helm-legacy-diff: guard-SERVICE guard-ENV kubernetes-check-context ## Show diff of an installation/upgrade of the release (SERVICE=xxx ENV=xxx)
	@echo "WARNING: You're using a deprecated way of managing Helm charts. Please adapt you code. (https://www.notion.so/skale-5/HELM-Point-du-2022-09-27-7605b4b0e4b94648a607d1283f3bd4cf)" && \
		source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		source makefiles/common/scripts/merge-charts.sh $(SERVICE) $(ENV) && \
		helm diff upgrade --install $$CHART_RELEASE_NAME $${CHART_PATH:-$$CHART_REPO_NAME/$$CHART_NAME} \
		--namespace $$CHART_NAMESPACE -f $$FILE \
		--version $$CHART_VERSION

.PHONY: helm-legacy-install
helm-legacy-install: guard-SERVICE guard-ENV kubernetes-check-context ## Install/Upgrade the release (SERVICE=xxx ENV=xxx)
	@echo "WARNING: You're using a deprecated way of managing Helm charts. Please adapt you code. (https://www.notion.so/skale-5/HELM-Point-du-2022-09-27-7605b4b0e4b94648a607d1283f3bd4cf)" && \
		source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		source makefiles/common/scripts/merge-charts.sh $(SERVICE) $(ENV) && \
		helm upgrade --install $$CHART_RELEASE_NAME $${CHART_PATH:-$$CHART_REPO_NAME/$$CHART_NAME} \
		--namespace $$CHART_NAMESPACE -f $$FILE \
		--version $$CHART_VERSION --create-namespace

.PHONY: helm-legacy-uninstall
helm-legacy-uninstall: guard-SERVICE guard-ENV kubernetes-check-context ## Uninstall the release (SERVICE=xxx ENV=xxx)
	@echo "WARNING: You're using a deprecated way of managing Helm charts. Please adapt you code. (https://www.notion.so/skale-5/HELM-Point-du-2022-09-27-7605b4b0e4b94648a607d1283f3bd4cf)" && \
		source $(SERVICE)/chart.sh && source $(SERVICE)/values/$(ENV)/chart.sh && \
		helm uninstall $$CHART_RELEASE_NAME --namespace $$CHART_NAMESPACE
