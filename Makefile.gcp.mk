# Copyright (C) 2022 Skale-5 <ops@skale-5.com>

include gcp.*.mk

include makefiles/common/common.mk
include makefiles/gcp/gcp.mk
include makefiles/custom/*.mk

include makefiles/common/helm.mk
include makefiles/common/kustomize.mk
include makefiles/common/custom/*.mk

include makefiles/gcp/ansible.mk
include makefiles/gcp/diagrams.mk
include makefiles/gcp/dev.mk
include makefiles/gcp/gcloud.mk
include makefiles/gcp/packer.mk
include makefiles/gcp/terraform.mk
include makefiles/gcp/custom/*.mk

-include $(HOME)/.config/makefiles/*.mk
