
# Copyright 2017-present Open Networking Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM golang:1.7-alpine as builder
MAINTAINER Open Networking Laboratory <info@onlab.us>

WORKDIR /go
ADD . /go/src/gerrit.opencord.org/maas/cord-provisioner
RUN go build -o /build/entry-point gerrit.opencord.org/maas/cord-provisioner

FROM alpine:3.7
MAINTAINER Open Networking Laboratory <info@onlab.us>

# Base image information borrowed by official golang wheezy Dockerfile
RUN apk --update add ansible openssh-client sshpass curl py2-netaddr rsync
COPY ssh-config /root/.ssh/config
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/config
COPY ansible.cfg /etc/ansible/ansible.cfg
COPY --from=builder /build/entry-point /service/entry-point

LABEL org.label-schema.name="provisioner" \
      org.label-schema.description="Provides provisioning of compute and switch nodes for CORD" \
      org.label-schema.vcs-url="https://gerrit.opencord.org/maas" \
      org.label-schema.vendor="Open Networking Laboratory" \
      org.label-schema.schema-version="1.0"

WORKDIR /service
ENTRYPOINT ["/service/entry-point"]
