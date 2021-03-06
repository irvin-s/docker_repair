# Copyright 2017 OpenCensus Authors
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

ARG BASE_IMAGE
FROM $BASE_IMAGE

RUN mkdir -p /build && \
    apt-get update -y && \
    apt-get install -y -q --no-install-recommends \
        build-essential \
        g++ \
        gcc \
        libc-dev \
        make \
        autoconf \
        curl \
        git-core \
        unzip

COPY . /build/

WORKDIR /build

ENV TEST_PHP_ARGS="-q" \
    REPORT_EXIT_STATUS=1

RUN phpize && \
    ./configure --enable-stackdriver-debugger && \
    make clean && \
    make && \
    make test || ((find . -name '*.diff' | xargs cat) && false) && \
    make install && \
    (composer -V || scripts/install_composer.sh) && \
    scripts/run_functional_tests.sh
