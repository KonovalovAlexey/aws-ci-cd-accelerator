# Changelog

All notable changes to this project will be documented in this file.

## 1.0.0 (2024-01-07)


### ⚠ BREAKING CHANGES

* Changed initial bootstrapping process to be able  an accelerator's CI/CD to work with different accounts and regions.

### Features

* **AI:** 1. Added a possibility to process terraform errors by Open AI. 2. Added a possibility to process errors from Sonar by Open AI. 3. Added possibility to create description, comments, and Unit tests for user application code. ([03bc8f2](https://github.com/KonovalovAlexey/aws-ci-cd-accelerator/commit/03bc8f231b4738eab9cd537ea73c9e26e6e7647f))
* **Carrier:** Added EPAM Carrier for an application performance testing. ([ef3b5d1](https://github.com/KonovalovAlexey/aws-ci-cd-accelerator/commit/ef3b5d19f6d4dfa318776c19d82d1336093cac15))
* Changed initial bootstrapping process to be able  an accelerator's CI/CD to work with different accounts and regions. ([483fa2a](https://github.com/KonovalovAlexey/aws-ci-cd-accelerator/commit/483fa2a5d9112822a77eb8af2ce5b42befc2fef4))
* **docker image:** Added possibility to check Git tag or to create it for an application code, tagging created docker image with the same version and scan this image for vulnerabilities by Trivy. ([0cb5ace](https://github.com/KonovalovAlexey/aws-ci-cd-accelerator/commit/0cb5aceae6f52379c42c3fc195bb4d33d4069577))
* **Synthetics:** Added AWS CloudWatch Synthetics for functional testing of applications. ([f6c0495](https://github.com/KonovalovAlexey/aws-ci-cd-accelerator/commit/f6c0495f31069410528968c681dce252ee3f083b))


### Bug Fixes

* **modules:** Updated modules version accordingly the current versions of Open Source Terraform modules. ([3ff9f9b](https://github.com/KonovalovAlexey/aws-ci-cd-accelerator/commit/3ff9f9b1ca111c7ee55c3d1562e1f2a56565950b))
