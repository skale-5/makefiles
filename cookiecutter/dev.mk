# ====================================
# D E V E L O P M E N T
# ====================================

##@ Development

.PHONY: check
check: check-cookiecutter check-terraform-docs check-pre-commit## Check requirements

.PHONY: ci
ci:
	@rm -rf gitlab-ci/gitlab-ci && \
	git clone git@git.sk5.io:skale-5/gitlab-ci.git gitlab-ci/gitlab-ci && \
	rm -rf gitlab-ci/gitlab-ci/.git
