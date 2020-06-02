
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
ADD . /go/src/gerrit.opencord.org/maas/cord-maas-automation
RUN go build -o /build/entry-point gerrit.opencord.org/maas/cord-maas-automation

FROM alpine:3.5
MAINTAINER Open Networking Laboratory <info@onlab.us>

COPY --from=builder /build/entry-point /service/entry-point

LABEL org.label-schema.name="automation" \
      org.label-schema.description="Provides automation of the compute node deployment and provisioning process" \
      org.label-schema.vcs-url="https://gerrit.opencord.org/maas" \
      org.label-schema.vendor="Open Networking Laboratory" \
      org.label-schema.schema-version="1.0"

WORKDIR /service
ENTRYPOINT ["/service/entry-point"]
