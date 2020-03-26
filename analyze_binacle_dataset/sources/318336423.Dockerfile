# Latest version of ubuntu
FROM nvidia/cuda:9.0-base

# Default git repository
ENV GIT_REPOSITORY https://github.com/torquecoin/xtc-stak.git
ENV XMRSTAK_CMAKE_FLAGS -DXMR-STAK_COMPILE=generic -DCUDA_ENABLE=ON -DOpenCL_ENABLE=OFF

# Innstall packages
RUN apt-get update \
    && set -x \
    && apt-get install -qq --no-install-recommends -y build-essential ca-certificates cmake cuda-core-9-0 git cuda-cudart-dev-9-0 libhwloc-dev libmicrohttpd-dev libssl-dev \
    && git clone $GIT_REPOSITORY \
    && cd /xtc-stak \
    && cmake ${XMRSTAK_CMAKE_FLAGS} . \
    && make \
    && cd - \
    && mv /xtc-stak/bin/* /usr/local/bin/ \
    && rm -rf /xtc-stak \
    && apt-get purge -y -qq build-essential cmake cuda-core-9-0 git cuda-cudart-dev-9-0 libhwloc-dev libmicrohttpd-dev libssl-dev \
    && apt-get clean -qq

VOLUME /mnt

WORKDIR /mnt

ENTRYPOINT ["/usr/local/bin/xtc-stak"]
