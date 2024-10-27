## [2.0.2](https://git.sk5.io/skale-5/makefiles/compare/v2.0.1...v2.0.2) (2024-10-27)


### Bug Fixes

* **helm:** align helmfile usage with CICD ([9977f02](https://git.sk5.io/skale-5/makefiles/commit/9977f023314e74346985ebc1974bbb0a1eea2dbb))

## [2.0.1](https://git.sk5.io/skale-5/makefiles/compare/v2.0.0...v2.0.1) (2024-06-23)


### Bug Fixes

* **aws:** remove comment causing space in 'KUBE_CONTEXT' var ([9d7573a](https://git.sk5.io/skale-5/makefiles/commit/9d7573acaf29a9fcc637192873621ffc0056f6f9))

# [2.0.0](https://git.sk5.io/skale-5/makefiles/compare/v1.4.0...v2.0.0) (2024-03-28)


* Merge branch 'feat/convert-to-helmfile' into 'main' ([a06f44c](https://git.sk5.io/skale-5/makefiles/commit/a06f44c8fc6274aab8bc0c7c454703028087c235))


### BREAKING CHANGES

* replace helm commands with helmfile

See merge request skale-5/makefiles!32

# [1.4.0](https://git.sk5.io/skale-5/makefiles/compare/v1.3.0...v1.4.0) (2023-11-12)


### Features

* **terraform:** Add "terraform-output" target; Remove ENV requirement from "terraform-providers-lock" target ([bc7b567](https://git.sk5.io/skale-5/makefiles/commit/bc7b5675fb30deadf18cc7bc864dddd4f9f5e96d))

# [1.3.0](https://git.sk5.io/skale-5/makefiles/compare/v1.2.0...v1.3.0) (2023-09-03)


### Bug Fixes

* wrong warning message ([4345219](https://git.sk5.io/skale-5/makefiles/commit/43452199c72781053a864f05363dd5ac56213a6c))


### Features

* **gke-credentials:** add new target to get creds of private gke cluster ([2a3900a](https://git.sk5.io/skale-5/makefiles/commit/2a3900ab64a2791461d03e9b6ddc0619fa871a9c))

# [1.2.0](https://git.sk5.io/skale-5/makefiles/compare/v1.1.2...v1.2.0) (2023-06-25)


### Bug Fixes

* **helm:** fix bad values merging ([3fc86f6](https://git.sk5.io/skale-5/makefiles/commit/3fc86f6c05442b76f37d503f6667a9e33b9504bc))
* **k8s:** use cluster name instead of context name ([35cdbcf](https://git.sk5.io/skale-5/makefiles/commit/35cdbcf430e63728f5b89110cb6122b453f0391d)), closes [#11](https://git.sk5.io/skale-5/makefiles/issues/11)


### Features

* update make check ([7a1f3d1](https://git.sk5.io/skale-5/makefiles/commit/7a1f3d1d1ac8228ea51782b7f02ddb9c62d0af55))

## [1.1.2](https://git.sk5.io/skale-5/makefiles/compare/v1.1.1...v1.1.2) (2023-06-11)


### Bug Fixes

* activate support for legacy way of handling chart.sh ([6291b4a](https://git.sk5.io/skale-5/makefiles/commit/6291b4af3271812adabaf5d4576cab3366ddc0d1))

## [1.1.1](https://git.sk5.io/skale-5/makefiles/compare/v1.1.0...v1.1.1) (2023-06-04)


### Bug Fixes

* align helm with cicd generator ([16bd95f](https://git.sk5.io/skale-5/makefiles/commit/16bd95f0477a308102f36ea28dcaf94dac0379b6))

# [1.1.0](https://git.sk5.io/skale-5/makefiles/compare/v1.0.0...v1.1.0) (2023-05-23)


### Bug Fixes

* **helm:** Fix the conditional check before sourcing chart.sh ([7f24cda](https://git.sk5.io/skale-5/makefiles/commit/7f24cda9df057187063a03a0a4e10d295b003c3c))


### Features

* deprecate make ci as cicd-generator moves to v2 ([41cdbd6](https://git.sk5.io/skale-5/makefiles/commit/41cdbd65c1dedd8799ed9069fc3e30de63c3bc8b))

# 1.0.0 (2023-05-21)


### Bug Fixes

* add custom empty mk files ([39accaa](https://git.sk5.io/skale-5/makefiles/commit/39accaaa51bdd1b46d752bbdefd0e74fcb160db8))
* **ansible:** remove useless grep condition ([5b8904f](https://git.sk5.io/skale-5/makefiles/commit/5b8904f840b25b9a840bd1bd993c09ef779215f7))
* **bastion:** fix to be listed by make help ([c2668c3](https://git.sk5.io/skale-5/makefiles/commit/c2668c3a110c9cc2f6cd20d157c39e25d69dca04))
* cicd generator command ([a1433c7](https://git.sk5.io/skale-5/makefiles/commit/a1433c7d272467ab148869e3ce95d2844c174a22))
* fix include path ([17ad4cc](https://git.sk5.io/skale-5/makefiles/commit/17ad4ccc3e625aa700a6d8cf7458d80c2c7a2e9d))
* fix typo ([5dd6afa](https://git.sk5.io/skale-5/makefiles/commit/5dd6afab5827920b4aca734200e4b83339bb6be5))
* **gcp/gcloud:** use a zone for bastion ([6cbc055](https://git.sk5.io/skale-5/makefiles/commit/6cbc055bb3ea77afc3f9409af5676afb170aef80))
* requirements path ([9d0e6df](https://git.sk5.io/skale-5/makefiles/commit/9d0e6dfbcceeda707fefb0483b1a9057423faa58))
* **terraform-show:** Typo ([71ebf4f](https://git.sk5.io/skale-5/makefiles/commit/71ebf4f0abe86aa8f694ad9bbe2dc4637044e11c))


### Features

* add tfswitch for aws ([466dd19](https://git.sk5.io/skale-5/makefiles/commit/466dd19a8d2f8713342ce7378ee1c190b938ce8b))
* add tfswitch for gcp ([8df477d](https://git.sk5.io/skale-5/makefiles/commit/8df477d90ca00bd8cef99f13fe987767fd6c96a7))
* **cicd-generator:** add regen cicd generator ([3f7877b](https://git.sk5.io/skale-5/makefiles/commit/3f7877ba48752deb4ccc4561898c8c545b43a7b9)), closes [#1](https://git.sk5.io/skale-5/makefiles/issues/1) [#3](https://git.sk5.io/skale-5/makefiles/issues/3)
* **cookiecutter:** add regen CI ([a266afa](https://git.sk5.io/skale-5/makefiles/commit/a266afa06ead9172e2191949e2ac234fc6630729))
* **merge-charts:** move script from gcp-cookiecutter to makefiles repo ([41bee08](https://git.sk5.io/skale-5/makefiles/commit/41bee085f764cfd154441aee8c3c83c8c1b02998))
* **oslogin-iap:** add multiple commands ([011fc85](https://git.sk5.io/skale-5/makefiles/commit/011fc855d014a721663c8d84f35d93cee64d87e8))
* remove make ci command ([7322fdd](https://git.sk5.io/skale-5/makefiles/commit/7322fdd27aadf25be05dcc59583089a314dbfc8c))
* rename make cicd-generator in make ci ([a0c726d](https://git.sk5.io/skale-5/makefiles/commit/a0c726de90821b2cecc2e8dc9dcbdd44c1f53e4a))
* use only custom_merge if it is needed ([324c24a](https://git.sk5.io/skale-5/makefiles/commit/324c24aa87116117c5a61139add33cf9958e4dd8))
