# Copyright 2017 Google Inc.
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

ARG DISTRO_VERSION=18.04
FROM ubuntu:${DISTRO_VERSION}

RUN apt update && \
    apt install -y \
        abi-compliance-checker \
        abi-dumper \
        automake \
        build-essential \
        ccache \
        clang \
        cmake \
        curl \
        doxygen \
        gawk \
        git \
        gcc \
        g++ \
        cmake \
        libcurl4-openssl-dev \
        libssl-dev \
        libtool \
        lsb-release \
        make \
        pkg-config \
        python-pip \
        shellcheck \
        tar \
        unzip \
        wget \
        zlib1g-dev

# By default, Ubuntu 18.04 does not install the alternatives for clang-format
# and clang-tidy, so we need to manually install those.
RUN if grep -q 18.04 /etc/lsb-release; then \
      apt update && apt install -y clang-tidy clang-format-7 clang-tools; \
      update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-6.0 100; \
      update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-7 100; \
      update-alternatives --install /usr/bin/scan-build scan-build /usr/bin/scan-build-6.0 100; \
    fi

# Install the the buildifier tool, which does not compile with the default
# golang compiler for Ubuntu 16.04 and Ubuntu 18.04.
RUN wget -q -O /usr/bin/buildifier https://github.com/bazelbuild/buildtools/releases/download/0.17.2/buildifier
RUN chmod 755 /usr/bin/buildifier

# Install cmake_format to automatically format the CMake list files.
#     https://github.com/cheshirekow/cmake_format
# Pin this to an specific version because the formatting changes when the
# "latest" version is updated, and we do not want the builds to break just
# because some third party changed something.
RUN pip install --upgrade pip
RUN pip install numpy cmake_format==0.4.0

# Install Python packages used in the integration tests.
RUN pip install flask httpbin gevent gunicorn crc32c

# Install the Cloud Bigtable emulator and the Cloud Bigtable command-line
# client.  They are used in the integration tests.
COPY . /var/tmp/ci
WORKDIR /var/tmp/downloads
RUN /var/tmp/ci/install-cloud-sdk.sh

# Install Bazel because some of the builds need it.
RUN /var/tmp/ci/install-bazel.sh
