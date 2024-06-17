# ====================================
# K U B E R N E T E S
# ====================================

##@ Kubernetes

kubernetes-check-context:
	@if [[ "${KUBE_CONTEXT}" != "${KUBE_CURRENT_CONTEXT}" ]] ; then \
		echo -e "$(ERROR_COLOR)[KO]$(NO_COLOR) Kubernetes context: '${KUBE_CONTEXT}' vs '${KUBE_CURRENT_CONTEXT}'"; \
		exit 1; \
	fi

.PHONY: kubernetes-switch
kubernetes-switch: guard-ENV ## Switch Kubernetes context
	@kubectl config use-context $(KUBE_CONTEXT)

.PHONY: kubernetes-manifests
kubernetes-manifests: guard-COMPONENT guard-VERSION ## Install manifests from remote bases
	@cd manifests && ../sk5-scripts/kube-manifests.sh $(COMPONENT) $(VERSION) && cd ..

.PHONY: kubernetes-admin
kubernetes-admin: guard-ENV ## Set current user as a cluster admin
	@echo -e "$(OK_COLOR)[$(BANNER)] Set user as admin$(NO_COLOR)"
	kubectl create clusterrolebinding cluster-admin-binding \
		--clusterrole=cluster-admin \
		--user=$$(gcloud config get-value core/account)

.PHONY: kubernetes-validate
kubernetes-validate: guard-SERVICE guard-ENV ## Validate Kubernetes manifests on Kustomization (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Validate kustomization ${SERVICE}:${ENV}$(NO_COLOR)"
	@kustomize build $(SERVICE)/overlays/$(ENV) | kubeval -o tap -v $(KUBE_VERSION) --ignore-missing-schemas

.PHONY: kubernetes-policy
kubernetes-policy: guard-SERVICE guard-ENV guard-POLICY ## Check policies on Kustomization (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Policy kustomization ${SERVICE}:${ENV}$(NO_COLOR)"
	@kustomize build $(SERVICE)/overlays/$(ENV) | conftest test -p addons/policies/$(POLICY) -

.PHONY: kubernetes-reporting
kubernetes-reporting: ## Scan cluster and reports potential issues
	@echo -e "$(OK_COLOR)[$(BANNER)] Reporting cluster status ${SERVICE}:${ENV}$(NO_COLOR)"
	@popeye --context $(KUBE_CONTEXT)

.PHONY: kubernetes-build
kubernetes-build: guard-SERVICE guard-ENV ## Build Kustomization (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Build kustomization ${SERVICE}:${ENV}$(NO_COLOR)"
	@kustomize build $(SERVICE)/overlays/$(ENV)

.PHONY: kubernetes-apply
kubernetes-apply: guard-SERVICE guard-ENV kubernetes-check-context ## Apply Kustomization (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Apply kustomization ${SERVICE}:${ENV}$(NO_COLOR)"
	@kustomize build $(SERVICE)/overlays/$(ENV)|kubectl apply --validate=false -f -

.PHONY: kubernetes-diff
kubernetes-diff: guard-SERVICE guard-ENV kubernetes-check-context ## Diff live version against would-be applied version (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Diff live version against would-be applied version ${SERVICE}:${ENV}$(NO_COLOR)"
	@kustomize build $(SERVICE)/overlays/$(ENV)| kubectl diff -f - || test $$? -eq 1

.PHONY: kubernetes-dryrun
kubernetes-dryrun: guard-SERVICE guard-ENV kubernetes-check-context ## Apply kustomization (Dry-Run) (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Apply kustomization (Dry-Run) ${SERVICE}:${ENV}$(NO_COLOR)"
	@kustomize build $(SERVICE)/overlays/$(ENV)| kubectl apply --dry-run=server --validate=false -f -

.PHONY: kubernetes-delete
kubernetes-delete: guard-SERVICE guard-ENV kubernetes-check-context ## Delete Kustomization (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(BANNER)] Delete kustomization ${SERVICE}:${ENV}$(NO_COLOR)"
	@kustomize build $(SERVICE)/overlays/$(ENV)|kubectl delete -f -