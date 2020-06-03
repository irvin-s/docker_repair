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


# Building SpecJBB
FROM centos:7

RUN yum -y update
RUN yum install -y epel-release && yum makecache
RUN yum install -y java-1.8.0-openjdk-devel && yum install -y python36

# add the specjbb to docker
COPY specjbb /home/specjbb

# add specjbb custom wrapper to docker
COPY /dist/specjbb_wrapper.pex /usr/bin/specjbb_wrapper.pex

# Note: will be ignored by mesos
WORKDIR /home/specjbb

# Notes:
# path to main executable is:
# /home/specjbb/spejbb2015.jar
# path to wrapper is:
# /usr/bin/specjbb_wrapper.pex
