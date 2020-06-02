# Copyright (c) 2018 Intel Corporation
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


# Building stress-ng.
FROM centos:7 AS stress-ng

RUN yum install -y gcc git make wget patch
RUN wget http://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-0.09.28.tar.xz
RUN tar -xf stress-ng-0.09.28.tar.xz
WORKDIR /stress-ng-0.09.28
ADD APM.patch APM.patch
RUN cat APM.patch | patch -p 1
RUN make

# Builing final container that consists of workloads only.
FROM centos:7

RUN yum install -y epel-release
RUN yum makecache
RUN yum install -y python36
RUN useradd -M stress-ng
COPY /dist/stress_ng_wrapper.pex /usr/bin/stress_ng_wrapper.pex
COPY --from=stress-ng /stress-ng-0.09.28/stress-ng /usr/bin/stress-ng
