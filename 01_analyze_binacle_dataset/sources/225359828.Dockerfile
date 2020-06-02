# pubnative/pyspark-ci:data-science-ci-${COMMIT}

FROM pubnative/pyspark-ci:data-science-base-0eb4c1a

ARG BAZEL_VERSION="0.25.1"
ENV BAZEL_URL=https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh

ENV DOCKER_REPO="deb [arch=amd64] https://download.docker.com/linux/debian stretch stable"
ENV DOCKER_RELEASE_KEY_URL="https://download.docker.com/linux/debian/gpg"

RUN apt-get update && apt-get install -y apt-transport-https

RUN ["/bin/bash", "-c", "set -o pipefail \
    && apt-get install -y \
      g++ \
      pkg-config \
      python \
      unzip \
      zip \
      zlib1g-dev \
    && curl \
      -fsSL ${BAZEL_URL} \
      -o /lib/bazel_installer.sh \
    && chmod +x /lib/bazel_installer.sh \
    && /lib/bazel_installer.sh"]
    
RUN ["/bin/bash", "-c", "set -o pipefail \
    && curl -fsSL ${DOCKER_RELEASE_KEY_URL} \
    | apt-key add - \
    && echo ${DOCKER_REPO} \
    | tee /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y \
      docker-ce \
      docker-ce-cli \
      containerd.io"]
