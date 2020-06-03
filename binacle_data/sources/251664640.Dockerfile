# Copyright 2016 Acquia, Inc.
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

FROM       ubuntu:latest
MAINTAINER Acquia Engineering <engineering@acquia.com>

ENV GOLANG_VERSION 1.7.1
ENV DEBIAN_FRONTEND noninteractive

# Setup container dependencies
RUN apt-get -y update \
  && apt-get -y install \
    build-essential \
    curl \
    git \

  # Install Go
  && curl -sSL https://storage.googleapis.com/golang/go${GOLANG_VERSION}.linux-amd64.tar.gz | tar -C /usr/lib/ -xz \
  && mkdir -p /usr/share/go

# Setup env and install glide for Development
ENV GOROOT /usr/lib/go
ENV GOPATH /usr/share/go
ENV PATH ${GOROOT}/bin:${GOPATH}/bin:$PATH

RUN go get -u github.com/Masterminds/glide

# Cleanup
RUN apt-get clean \
  && rm -rf /var/cache/apt/* \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && rm -rf /var/tmp/*

WORKDIR /usr/share/go/src/github.com/acquia/aws-proxy
CMD ["bash"]
