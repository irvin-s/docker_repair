#
# Copyright SecureKey Technologies Inc. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

# Start from the sk dynamic ccenv for now, but will be fabric-ccenv image in future
ARG    FABRIC_CCENV_IMAGE=hyperledger/fabric-ccenv
ARG    FABRIC_CCENV_TAG=ARG_REQUIRED

# FROM CONTAINER
FROM   ${FABRIC_CCENV_IMAGE}:${FABRIC_CCENV_TAG}

# LABELS
LABEL  maintainer=sk-dev-team

# Mark current sources for amd64 arch
RUN    set -ex; sed -i "s/deb /deb [arch=amd64] /" /etc/apt/sources.list && \
       # Add the ubuntu ports source for the s390x architecture
       echo "deb [arch=s390x] http://ports.ubuntu.com/ubuntu-ports xenial main restricted universe multiverse" >> /etc/apt/sources.list.d/s390x.list && \
       echo "deb [arch=s390x] http://ports.ubuntu.com/ubuntu-ports xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list.d/s390x.list && \
       echo "deb [arch=s390x] http://ports.ubuntu.com/ubuntu-ports xenial-security main restricted universe multiverse" >> /etc/apt/sources.list.d/s390x.list && \
       echo "deb [arch=s390x] http://ports.ubuntu.com/ubuntu-ports xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list.d/s390x.list && \
       # Add the s390x architecture
       dpkg --add-architecture s390x && \
       # Update list of packages
       apt-get update && \
       # Install essential s390x lib tools
       apt-get install -y libc6-dev:s390x libltdl-dev:s390x gcc-multilib-s390x-linux-gnu
