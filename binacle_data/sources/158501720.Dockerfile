#
# Copyright SecureKey Technologies Inc. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

ARG FABRIC_BASE_IMAGE=hyperledger/fabric-baseimage
ARG ARCH=amd64
ARG FABRIC_BASE_VERSION=0.4.8

FROM ${FABRIC_BASE_IMAGE}:${ARCH}-${FABRIC_BASE_VERSION}
LABEL maintainer=sk-dev-team
