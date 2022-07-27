# ====================================
# A N S I B L E
# ====================================

##@ Ansible

.PHONY: ansible-init
ansible-init: ## Install requirements
	@echo -e "$(OK_COLOR)[$(CUSTOMER)] Install requirements$(NO_COLOR)"
	@test -d $(ANSIBLE_VENV) || python3 -m venv $(ANSIBLE_VENV)
	@. $(ANSIBLE_VENV)/bin/activate \
		&& pip3 install pip --upgrade \
		&& pip3 install ansible==$(ANSIBLE_VERSION) molecule==$(MOLECULE_VERSION) docker google-auth jmespath

.PHONY: ansible-deps
ansible-deps: guard-SERVICE ## Install dependencies (SERVICE=xxx)
	@echo -e "$(OK_COLOR)[$(CUSTOMER)] Install dependencies$(NO_COLOR)"
ifneq ("$(wildcard $(SERVICE)/ansible/requirements-collections.yml)","")
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ANSIBLE_CONFIG=$(SERVICE)/ansible/ansible.cfg \
		ansible-galaxy collection install -r $(SERVICE)/ansible/requirements-collections.yml -p $(ANSIBLE_ROLES) --force \
		&& ANSIBLE_CONFIG=$(SERVICE)/ansible/ansible.cfg \
		ansible-galaxy install -r $(SERVICE)/ansible/requirements.yml -p $(ANSIBLE_ROLES) --force
else
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ANSIBLE_CONFIG=$(SERVICE)/ansible/ansible.cfg \
		ansible-galaxy install -r $(SERVICE)/ansible/requirements.yml -p $(ANSIBLE_ROLES) --force
endif

.PHONY: ansible-create
ansible-create: guard-SERVICE guard-NAME ## Create a new role
	@echo -e "$(OK_COLOR)[$(BANNER)] Create new role$(NO_COLOR)"
	@. $(ANSIBLE_VENV)/bin/activate \
		&& cd $(SERVICE)/ansible/roles/ \
		&& molecule init role -r $(NAME) -d docker

.PHONY: ansible-ping
ansible-ping: guard-SERVICE guard-ENV ## Check Ansible installation (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(CUSTOMER)] Check Ansible$(NO_COLOR)"
ifneq ("$(wildcard $(SERVICE)/ansible/inventories/$(ENV).gcp.yml)","")
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ANSIBLE_CONFIG=$(SERVICE)/ansible/ansible.cfg \
		ANSIBLE_COLLECTIONS_PATH=$(ANSIBLE_COLLECTIONS_PATH) \
		ANSIBLE_ROLES_PATH=$(SERVICE)/ansible/roles/:$(ANSIBLE_ROLES_PATH) \
		ansible -c local -m ping all -i $(SERVICE)/ansible/inventories/$(ENV).gcp.yml
else
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ANSIBLE_CONFIG=$(SERVICE)/ansible/ansible.cfg \
		ANSIBLE_COLLECTIONS_PATH=$(ANSIBLE_COLLECTIONS_PATH) \
		ANSIBLE_ROLES_PATH=$(SERVICE)/ansible/roles/:$(ANSIBLE_ROLES_PATH) \
		ansible -c local -m ping all -i $(SERVICE)/ansible/inventories/$(ENV).ini
endif

.PHONY: ansible-debug
ansible-debug: guard-SERVICE guard-ENV ## Retrieve informations from hosts (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(CUSTOMER)] Check Ansible$(NO_COLOR)"
ifneq ("$(wildcard $(SERVICE)/ansible/inventories/$(ENV).gcp.yml)","")
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ANSIBLE_CONFIG=$(SERVICE)/ansible/ansible.cfg \
		ANSIBLE_COLLECTIONS_PATH=$(ANSIBLE_COLLECTIONS_PATH) \
		ANSIBLE_ROLES_PATH=$(SERVICE)/ansible/roles/:$(ANSIBLE_ROLES_PATH) \
		ansible -m setup all -i $(SERVICE)/ansible/inventories/$(ENV).gcp.yml
else
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ANSIBLE_CONFIG=$(SERVICE)/ansible/ansible.cfg \
		ANSIBLE_COLLECTIONS_PATH=$(ANSIBLE_COLLECTIONS_PATH) \
		ANSIBLE_ROLES_PATH=$(SERVICE)/ansible/roles/:$(ANSIBLE_ROLES_PATH) \
		ansible -m setup all -i $(SERVICE)/ansible/inventories/$(ENV).ini
endif

.PHONY: ansible-graph
ansible-graph: guard-SERVICE guard-ENV ## Display dynamic inventory informations (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(CUSTOMER)] Display dynamic inventory informations$(NO_COLOR)"
ifneq ("$(wildcard $(SERVICE)/ansible/inventories/$(ENV).gcp.yml)","")
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ANSIBLE_CONFIG=$(SERVICE)/ansible/ansible.cfg \
		ANSIBLE_COLLECTIONS_PATH=$(ANSIBLE_COLLECTIONS_PATH) \
		ANSIBLE_ROLES_PATH=$(SERVICE)/ansible/roles/:$(ANSIBLE_ROLES_PATH) \
		ansible-inventory -i $(SERVICE)/ansible/inventories/$(ENV).gcp.yml --graph
endif

.PHONY: ansible-run
ansible-run: guard-SERVICE guard-ENV ## Execute Ansible playbook (SERVICE=xxx ENV=xxx)
	@if [ ! -n "$(SKIP_DEPS)" ];then \
		echo -e "I will pull deps for you, next time you can use SKIP_DEPS=true "; \
		. $(ANSIBLE_VENV)/bin/activate \
			&& make ansible-deps SERVICE=$(SERVICE) ENV=$(ENV); \
	fi
	@echo -e "$(OK_COLOR)[$(CUSTOMER)] Execute Ansible playbook$(NO_COLOR)"
ifneq ("$(wildcard $(SERVICE)/ansible/inventories/$(ENV).gcp.yml)","")
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ANSIBLE_CONFIG=$(SERVICE)/ansible/ansible.cfg \
		ANSIBLE_COLLECTIONS_PATH=$(ANSIBLE_COLLECTIONS_PATH) \
		ANSIBLE_ROLES_PATH=$(SERVICE)/ansible/roles/:$(ANSIBLE_ROLES_PATH) \
		ansible-playbook $(DEBUG) -i $(SERVICE)/ansible/inventories/$(ENV).gcp.yml $(SERVICE)/ansible/main.yml $(OPTIONS)
else
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ANSIBLE_CONFIG=$(SERVICE)/ansible/ansible.cfg \
		ANSIBLE_COLLECTIONS_PATH=$(ANSIBLE_COLLECTIONS_PATH) \
		ANSIBLE_ROLES_PATH=$(SERVICE)/ansible/roles/:$(ANSIBLE_ROLES_PATH) \
		ansible-playbook $(DEBUG) -i $(SERVICE)/ansible/inventories/$(ENV).ini $(SERVICE)/ansible/main.yml $(OPTIONS)
endif

.PHONY: ansible-dryrun
ansible-dryrun: guard-SERVICE guard-ENV ## Execute Ansible playbook (SERVICE=xxx ENV=xxx)
	@echo -e "$(OK_COLOR)[$(CUSTOMER)] Execute Ansible playbook$(NO_COLOR)"
ifneq ("$(wildcard $(SERVICE)/ansible/inventories/$(ENV).gcp.yml)","")
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ANSIBLE_CONFIG=$(SERVICE)/ansible/ansible.cfg \
		ANSIBLE_COLLECTIONS_PATH=$(ANSIBLE_COLLECTIONS_PATH) \
		ANSIBLE_ROLES_PATH=$(SERVICE)/ansible/roles/:$(ANSIBLE_ROLES_PATH) \
		ansible-playbook $(DEBUG) -i $(SERVICE)/ansible/inventories/$(ENV).gcp.yml $(SERVICE)/ansible/main.yml --check $(OPTIONS)
else
	@. $(ANSIBLE_VENV)/bin/activate \
		&& ANSIBLE_CONFIG=$(SERVICE)/ansible/ansible.cfg \
		ANSIBLE_COLLECTIONS_PATH=$(ANSIBLE_COLLECTIONS_PATH) \
		ANSIBLE_ROLES_PATH=$(SERVICE)/ansible/roles/:$(ANSIBLE_ROLES_PATH) \
		ansible-playbook $(DEBUG) -i $(SERVICE)/ansible/inventories/$(ENV).ini $(SERVICE)/ansible/main.yml --check $(OPTIONS)
endif
