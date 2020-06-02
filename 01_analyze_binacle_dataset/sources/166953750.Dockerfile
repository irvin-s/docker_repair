FROM test/flow-neos-abstract
MAINTAINER Marcin Ryzycki marcin@m12.io

ENV \
  T3APP_BUILD_REPO_URL=https://github.com/neos/flow-base-distribution.git \
  T3APP_BUILD_BRANCH=3.2

# Pre-install TYPO3 Flow into /tmp directory
RUN /build-typo3-app/pre-install-typo3-app.sh
