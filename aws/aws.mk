GCP_SK5_PROJECT = sk5-customers-bootstrap

ENVS = $(shell ls aws.*.mk | awk -F"." '{ print $$2 }')

AWS_REGION = $(AWS_REGION_$(ENV))
CLUSTER = $(CLUSTER_$(ENV))
KUBE_CONTEXT = $(KUBE_CONTEXT_$(ENV)) # is in fact the cluster name

KUBE_CURRENT_CONTEXT = $(shell kubectl config get-contexts $$(kubectl config current-context) --no-headers | awk '{print $$3}')
# is in fact the cluster name corresponding to the current context


KUBE_VERSION = 1.21.9
KUBECTL_VERSION = 1.23.4
KUSTOMIZE_VERSION = 3.4.0
CONFTEST_VERSION = v0.30.0
KUBEVAL_VERSION = 0.16.1
POPEYE_VERSION = 0.9.8
ANSIBLE_VERSION = 5.7.1
MOLECULE_VERSION = 3.6.1

ANSIBLE_VENV = $(DIR)/venv
ANSIBLE_ROLES = $(DIR)/roles/
ANSIBLE_COLLECTIONS_PATH = $(DIR)/roles/ansible_collections:~/.ansible/collections:/usr/share/ansible/collections
ANSIBLE_ROLES_PATH = $(DIR)/roles:~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
