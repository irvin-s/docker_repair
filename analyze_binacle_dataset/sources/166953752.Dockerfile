FROM test/flow-neos-abstract
MAINTAINER Marcin Ryzycki marcin@m12.io

ENV \
  T3APP_BUILD_REPO_URL=https://github.com/neos/neos-base-distribution.git \
  T3APP_BUILD_BRANCH=2.2 \
  T3APP_NEOS_SITE_PACKAGE=Neos.Demo

# Pre-install TYPO3 Neos into /tmp directory
RUN /build-typo3-app/pre-install-typo3-app.sh
