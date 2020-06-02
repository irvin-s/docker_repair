#
# Copyright SecureKey Technologies Inc. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

ARG FABRIC_NEXT_PEER_IMAGE=securekey/fabric-peer
ARG ARCH=x86_64
ARG FABRIC_NEXT_IMAGE_TAG=latest

FROM ${FABRIC_NEXT_PEER_IMAGE}:${ARCH}-${FABRIC_NEXT_IMAGE_TAG}
LABEL maintainer=sk-dev-team

COPY build/snaps/* /opt/extsysccs/
