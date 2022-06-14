# Copyright (C) 2022 Skale-5 <ops@skale-5.com>

include gcp.*.mk

include common/common.mk
include gcp/gcp.mk
include custom/*.mk

include common/helm.mk
include common/kustomize.mk
include common/custom/*.mk


include gcp/ansible.mk
include gcp/diagrams.mk
include gcp/dev.mk
include gcp/gcloud.mk
include gcp/packer.mk
include gcp/terraform.mk
include gcp/custom/*.mk
