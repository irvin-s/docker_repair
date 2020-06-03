##########################################################################
# Copyright 2017 Brad Geesaman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM buildpack-deps:jessie-scm
MAINTAINER Brad Geesaman "bradgeesaman+github@gmail.com"

RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    && rm -rf /var/cache/apt/* \
    && rm -rf /var/lib/apt/lists/* 

# Grab latest kubectl binary
RUN curl -sLO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && mkdir -p /usr/local/bin \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin

# Copy in needed files to root of image
COPY kube-bench /kube-bench
COPY cfg/ /cfg

# Kick off tests script
COPY run_checks.sh /run_checks.sh
CMD ["/bin/bash", "-c", "/run_checks.sh"]
