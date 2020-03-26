################################################################################
#
#    Copyright 2018 Adobe. All rights reserved.
#    This file is licensed to you under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License. You may obtain a copy
#    of the License at http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software distributed under
#    the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
#    OF ANY KIND, either express or implied. See the License for the specific language
#    governing permissions and limitations under the License.
#
################################################################################

FROM circleci/openjdk:8-jdk-node

LABEL maintainer="Adobe"

#
# Install Node 10
# from https://github.com/CircleCI-Public/circleci-dockerfiles/blob/master/openjdk/images/8u151-jdk/node/Dockerfile
#

# node installations command expect to run as root
USER root

# Use 10.15.0 LTS version
ENV NODE_VERSION=10.15.0

RUN ARCH= && dpkgArch="$(dpkg --print-architecture)" \
  && case "${dpkgArch##*-}" in \
    amd64) ARCH='x64';; \
    ppc64el) ARCH='ppc64le';; \
    s390x) ARCH='s390x';; \
    arm64) ARCH='arm64';; \
    armhf) ARCH='armv7l';; \
    i386) ARCH='x86';; \
    *) echo "unsupported architecture"; exit 1 ;; \
  esac \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" \
  && curl -SLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
  && rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
  && ln -sf /usr/local/bin/node /usr/local/bin/nodejs

# Basic smoke test
RUN node --version

# Switch back to CircleCI user
USER circleci
WORKDIR /home/circleci

ENV SONAR_SCANNER_VERSION=3.2.0.1227-linux

# Install wsk
RUN mkdir bin && \
    cd bin && \
    wget -nv https://openwhisk.ng.bluemix.net/cli/go/download/linux/amd64/OpenWhisk_CLI-linux.tgz && \
    tar -xvzf OpenWhisk_CLI-linux.tgz && \
    rm OpenWhisk_CLI-linux.tgz && \
    chmod +x wsk

# Install sonar scanner
RUN cd bin && \
    wget -nv https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip && \
    unzip -q sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip && \
    rm sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip && \
    mv sonar-scanner-${SONAR_SCANNER_VERSION} sonar-scanner && \
    chmod +x sonar-scanner/bin/sonar-scanner

ENV PATH="${PATH}:/home/circleci/bin:/home/circleci/bin/sonar-scanner/bin"