# Copyright 2017 The Kubernetes Authors.
# Copyright 2017 The OpenEBS Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM alpine

MAINTAINER AmitD <amit.das@openebs.io>

ENV KUBE_LATEST_VERSION="v1.8.2"

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && cp /usr/bin/curl /usr/local/bin/curl \
 && chmod +x /usr/local/bin/curl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

COPY ./app /app
ENTRYPOINT /app
