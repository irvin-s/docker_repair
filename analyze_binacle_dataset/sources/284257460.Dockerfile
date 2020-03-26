# Copyright 2016 The Kubernetes Authors.
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

FROM golang:1.11.2

# RUN apt update
# RUN apt install -y ca-certificates

# DIST

# ADD /dist/kubectl /usr/local/bin/kubectl
# ADD /dist/helm /usr/local/bin/helm
# ADD /dist/kuber /usr/local/bin/kuber

# KUBER

# RUN cd /opt && \
#   git clone https://github.com/datalayer/datalayer && \
#   cd datalayer/kuber && \
#  make build && \
#   make install

RUN mkdir /dla
WORKDIR /dla

ADD dist/kuber kuber
ADD _static _static

# PORTS

EXPOSE 9091

# ENTRY POINT

ADD entry-point.sh /entry-point.sh

RUN chmod a+x /entry-point.sh

ENTRYPOINT ["/entry-point.sh"]
