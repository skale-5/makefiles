# Copyright (C) 2022 Skale-5 <ops@skale-5.com>

include aws.*.mk

include makefiles/common/common.mk
include makefiles/common/terraform.mk
include makefiles/aws/aws.mk
include makefiles/custom/*.mk

include makefiles/common/ansible.mk
include makefiles/common/helm.mk
include makefiles/common/kustomize.mk
include makefiles/common/custom/*.mk

include makefiles/aws/diagrams.mk
include makefiles/aws/dev.mk
include makefiles/aws/custom/*.mk

-include $(HOME)/.config/makefiles/*.mk
-include makefiles_custom/*.mk
