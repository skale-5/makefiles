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
	@echo -e "\e[38;5;11mWARNING\e[0m: Use this target only if your cluster have public endpoint enabled and you want to use public endpoint, in other cases, please use gke-get-credentials instead.\n"
	@gcloud container clusters get-credentials $(CLUSTER) --region $(GCP_REGION) --project $(GCP_PROJECT)

.PHONY: gke-get-credentials
gke-get-credentials: guard-ENV ## Generate credentials
	@gcloud container clusters get-credentials $(CLUSTER) --region $(GCP_REGION) --project $(GCP_PROJECT) --internal-ip

.PHONY: gcloud-os-login
gcloud-oslogin: guard-FILE ## Set SSH key in Google account (to use OSlogin) (FILE=xxx)
	@gcloud compute os-login ssh-keys add --key-file=$(FILE)

.PHONY: ssh
ssh: guard-ENV guard-NAME ## Use SSH through Gcloud (to use with OSLogin and IAP) (ENV=xxx, NAME=xxx)
	@export CLOUDSDK_PYTHON_SITEPACKAGES=1 \
	&& gcloud compute ssh --tunnel-through-iap --project $(GCP_PROJECT) $(NAME) $(SSH_OPTIONS)

.PHONY: scp
scp: guard-ENV guard-SRC guard-DEST ## Use SCP through Gcloud (to use with OSLogin and IAP) (ENV=xxx, SRC=xxx, DEST=xxx)
	@export CLOUDSDK_PYTHON_SITEPACKAGES=1 \
	&& gcloud compute scp --tunnel-through-iap --recurse --project $(GCP_PROJECT) $(SRC) $(DEST)

.PHONY: start-bastion-proxy
start-bastion-proxy: ## Start SSH tunnel via the bastion (to use with OSLogin and IAP)
	@echo -e "${WARN_COLOR}Usage of start-bastion-proxy is deprecated and will be removed soon, please use now sshoot https://git.sk5.io/skale-5/sshoot-config${NO_COLOR}" \
	&& export CLOUDSDK_PYTHON_SITEPACKAGES=1 \
	&& gcloud compute ssh --tunnel-through-iap --project $(GCP_PROJECT_${EXPLOIT_ENV}) --zone $(GCP_ZONE_BASTION_${EXPLOIT_ENV}) $(BASTION_NAME) -- -L 1337:127.0.0.1:8888 -L 1338:127.0.0.1:22 -D 9991 -N -q -f

.PHONY: stop-bastion-proxy
stop-bastion-proxy: ## Stop SSH tunnel via the bastion (to use with OSLogin and IAP)
	@kill $$(lsof -i tcp:1337 -t)
