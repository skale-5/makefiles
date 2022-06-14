# ====================================
# G C L O U D
# ====================================

##@ GCloud

.PHONY: gcloud-project-current
gcloud-project-current: ## Display current GCP project
	@gcloud info --format='value(config.project)'

.PHONY: gcloud-project-switch
gcloud-project-switch: guard-ENV ## Switch GCP project (ENV=xxx)
	@gcloud config set project ${GCP_PROJECT}

.PHONY: gcloud-bucket-create
gcloud-bucket-create: guard-ENV ## Create bucket for bootstrap
	@echo -e "$(OK_COLOR)[$(BANNER)] Create bucket for bootstrap$(NO_COLOR)"
	gsutil mb -p $(GCP_SK5_PROJECT) -c "STANDARD" -l "europe-west1" -b on gs://$(CUSTOMER)-gcloud-tfstates

.PHONY: gcloud-kube-credentials
gcloud-kube-credentials: guard-ENV ## Generate credentials
	@gcloud container clusters get-credentials $(CLUSTER) --region $(GCP_REGION) --project $(GCP_PROJECT)
