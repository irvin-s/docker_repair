# Copyright 2018 ML2Grow BVBA
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
FROM python:3.6-alpine3.6

ARG EXTRA_BAZEL_ARGS

LABEL \
    com.ml2grow.license="Apache License 2.0" \
    com.ml2grow.url="https://www.ml2grow.com" \
    com.ml2grow.vcs-type="Git" \
    com.ml2grow.vcs-url="https://github.com/ml2grow/tensorflow-alpine"


ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV BAZEL_VERSION 0.11.0
ENV TENSORFLOW_VERSION 1.7.0

RUN apk update \
    && apk add --no-cache --virtual=.builddeps \
        bash \
        build-base \
        linux-headers \
        make \
        musl-dev \
        openjdk8 \
        wget \
        zip
ADD tf-${TENSORFLOW_VERSION}-alpine.patch /tmp/ 
RUN set -x \
    && cd /tmp \
    && $(ln -s /usr/local/bin/python3 /usr/bin/python) \
    && mkdir /tmp/bazel \
    && wget -q -O /tmp/bazel-dist.zip https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-dist.zip \
    && unzip -qd /tmp/bazel /tmp/bazel-dist.zip \
    && cd /tmp/bazel \
    && sed -i -e '/"-std=c++0x"/{h;s//"-fpermissive"/;x;G}' tools/cpp/cc_configure.bzl \
    && sed -i -e '/#endif  \/\/ COMPILER_MSVC/{h;s//#else/;G;s//#include <sys\/stat.h>/;G;}' third_party/ijar/common.h \
    && bash compile.sh \
    && cp -p output/bazel /usr/bin/ \
    && apk --no-cache add \
        jemalloc \
        libc6-compat \
        libexecinfo \
        libunwind \
    && apk --no-cache add --virtual .builddeps.1 \
        libexecinfo-dev \
        libunwind-dev \
        patch \
        perl \
        sed \
    && pip3 install --no-cache-dir wheel numpy \
    && wget -q -O - https://github.com/tensorflow/tensorflow/archive/v${TENSORFLOW_VERSION}.tar.gz \
        | tar -xzf - -C /tmp \
    && cd /tmp/tensorflow-${TENSORFLOW_VERSION} \
    && patch -s -p1 < ../tf-${TENSORFLOW_VERSION}-alpine.patch \
    && sed -i -e '/JEMALLOC_HAVE_SECURE_GETENV/d' third_party/jemalloc.BUILD \
    && PYTHON_BIN_PATH=/usr/local/bin/python3 \
        PYTHON_LIB_PATH=/usr/local/lib/python3.6/site-packages \
        CC_OPT_FLAGS="-march=native" \
        TF_NEED_JEMALLOC=1 \
        TF_NEED_GCP=0 \
        TF_NEED_HDFS=0 \
        TF_NEED_S3=0 \
        TF_ENABLE_XLA=0 \
        TF_NEED_GDR=0 \
        TF_NEED_VERBS=0 \
        TF_NEED_OPENCL=0 \
        TF_NEED_CUDA=0 \
        TF_NEED_MPI=0 \
        bash configure \
    && bazel build -c opt ${EXTRA_BAZEL_ARGS} //tensorflow/tools/pip_package:build_pip_package \
    && ./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg \
    && pip3 install --no-cache-dir /tmp/tensorflow_pkg/tensorflow-${TENSORFLOW_VERSION}-cp36-cp36m-linux_x86_64.whl \
    && apk del \
       .builddeps \
       .builddeps.1 \
    && rm -rf \
        /tmp/* \
        /root/.[acpw]* \
        /usr/bin/bazel

CMD ["python3"]
