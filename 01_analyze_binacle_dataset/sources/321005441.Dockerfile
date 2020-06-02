#Copyright (c) 2018 VMware, Inc. All Rights Reserved.
#
#SPDX-License-Identifier: MIT
FROM hashicorp/packer:light

ENV GOVC=https://github.com/vmware/govmomi/releases/download/v0.18.0/govc_linux_amd64.gz
ENV VSPHERE_CLONE=https://github.com/pivotal-cf/packer-builder-vsphere/releases/download/v2.0-beta4-pcf.2/packer-builder-vsphere-clone.linux

# use this instead of curling it below to always update on new base images.
# use the curl below for faster iterations on building while testing.
# ADD $OVA /bootstrap.ova

RUN apk update && apk add --virtual build-dependencies curl git bash jq openssh rsync py-pip python python-dev libffi-dev openssl-dev build-base && \
    pip install --upgrade pip && \
    pip install 'ansible<2.6'

RUN curl -L -o /bin/packer-builder-vsphere-clone ${VSPHERE_CLONE} && chmod +x /bin/packer-builder-vsphere-clone && \
    curl -L $GOVC | gunzip > /usr/bin/govc && chmod +x /usr/bin/govc

WORKDIR /deployroot/packer-ova-concourse
CMD [ "./loop.sh" ]

ENTRYPOINT [ "/bin/bash" ]
