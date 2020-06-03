#
# This file is just for development purposes.
# Might be useful during development of this image.
# It leverages Docker caching to speed up image building
# while you develop e.g. configure-typo3-app.sh script.
#
FROM million12/nginx-php:latest

# Add only selected files, to leverage build cache
ADD container-files/config container-files/etc /
ADD container-files/build-typo3-app/include-variables.sh \
  container-files/build-typo3-app/include-functions-common.sh \
  container-files/build-typo3-app/pre-install-typo3-app.sh \
  /build-typo3-app/

ENV \
  T3APP_BUILD_REPO_URL=https://github.com/neos/neos-base-distribution.git \
  T3APP_BUILD_BRANCH=2.2

RUN . /build-typo3-app/pre-install-typo3-app.sh

# Add all remaining files
ADD container-files /
