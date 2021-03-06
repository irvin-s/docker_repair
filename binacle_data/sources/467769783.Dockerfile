# Copyright (c) 2019 Red Hat, Inc.
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# Contributors:
#   Red Hat, Inc. - initial API and implementation

FROM ${BUILD_ORGANIZATION}/${BUILD_PREFIX}-theia-endpoint-runtime:${BUILD_TAG}

ENV GLIBC_VERSION=2.29-r0 \
    ODO_VERSION=v0.0.20 \
    OC_VERSION=v3.11.0 \
    OC_TAG=0cbc58b

# the plugin executes the commands relying on Bash
RUN apk add --no-cache bash && \
    # install glibc compatibility layer package for Alpine Linux
    # see https://github.com/openshift/origin/issues/18942 for the details
    wget -O glibc-${GLIBC_VERSION}.apk https://github.com/andyshinn/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk && \
    apk --update --allow-untrusted add glibc-${GLIBC_VERSION}.apk && \
    rm -f glibc-${GLIBC_VERSION}.apk && \
    # install odo
    wget -O /usr/local/bin/odo https://github.com/redhat-developer/odo/releases/download/${ODO_VERSION}/odo-linux-amd64 && \
    chmod +x /usr/local/bin/odo && \
    # install oc
    wget -O- https://github.com/openshift/origin/releases/download/${OC_VERSION}/openshift-origin-client-tools-${OC_VERSION}-${OC_TAG}-linux-64bit.tar.gz | tar xvz -C /usr/local/bin --strip 1
