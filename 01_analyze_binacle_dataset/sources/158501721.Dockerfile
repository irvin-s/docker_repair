#
# Copyright SecureKey Technologies Inc. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

ARG FABRIC_BASE_OS_IMAGE=hyperledger/fabric-baseos
ARG ARCH=amd64
ARG FABRIC_BASE_VERSION=0.4.8

FROM ${FABRIC_BASE_OS_IMAGE}:${ARCH}-${FABRIC_BASE_VERSION}
LABEL maintainer=sk-dev-team

RUN apt-get update
RUN apt-get install -y libltdl7
