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


# Building rpc-perf.
FROM centos:7 AS rpc-perf

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.26.2

RUN yum install -y gcc git make wget patch

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y

RUN git clone https://github.com/twitter/rpc-perf.git
WORKDIR /rpc-perf
RUN git checkout 1f77023337ab3c6904c3730546bdd2f31aca9f2d
COPY intel_rpc-perf.patch .
RUN git apply intel_rpc-perf.patch

RUN git clone https://github.com/brayniac/tic
WORKDIR /rpc-perf/tic
RUN git checkout 6a3cf06673e87ec466b59b21655dff6e03a31743
COPY intel_rpc-perf-tic.patch .
RUN git apply intel_rpc-perf-tic.patch
WORKDIR /rpc-perf

RUN git clone https://github.com/brayniac/ratelimit.git
WORKDIR /rpc-perf/ratelimit
RUN git checkout 0bf70c3ab557bf601a7eea836892a5f4828a10ef
COPY intel_rpc-perf-ratelimit.patch .
RUN git apply intel_rpc-perf-ratelimit.patch
WORKDIR /rpc-perf

RUN cargo build --release

# Builing final container that consists of workloads only.
FROM centos:7

RUN yum install -y epel-release
RUN yum makecache
RUN yum install -y python36

COPY /dist/rpc_perf_wrapper.pex /usr/bin/
COPY rpc-perf.toml /etc/
COPY --from=rpc-perf /rpc-perf/target/release/rpc-perf /usr/bin/
COPY --from=rpc-perf /rpc-perf/configs /etc/rpc-perf/
