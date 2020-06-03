# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM gcr.io/k8s-testimages/planter:0.25.2

ARG BUILD_DATE
ARG VCS_REF

LABEL \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="Apache License 2.0" \
    org.label-schema.name="Planter container with kubectl and google cloud sdk" \
    org.label-schema.url="https://github.com/GoogleCloudPlatform/" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/GoogleCloudPlatform/gke-bazel-demo"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
 set -ex -o pipefail \
 && apt-get update && apt-get install -y --no-install-recommends  apt-transport-https=1.4.9 gnupg2=2.1.18-8~deb9u4 \
 && wget -q -O - https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
 && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
 && CLOUD_SDK_REPO="cloud-sdk-stretch" \
 && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
 && wget -q -O - https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
 && apt-get update \
 && apt-get install -y --no-install-recommends kubectl=1.12.8-00 google-cloud-sdk=246.0.0-0 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
