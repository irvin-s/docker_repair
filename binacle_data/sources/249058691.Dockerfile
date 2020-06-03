FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-alpine:%%DOCKER_TAG%%

ENV OPENSTACK_COMPONENT="base-alpine-common-deps" \
    PYTHON_XATTR_PACKAGE="git+https://github.com/portdirect/xattr.git"

RUN set -e && \
    set -x && \
    cat /etc/apk/repositories > /etc/apk/repositories.bak && \
    apk add --no-cache --virtual build-deps1 \
        gcc \
        git \
        python-dev \
        linux-headers \
        libffi-dev \
        postgresql-dev \
        openssl-dev \
        libxml2-dev \
        libxslt-dev \
        curl \
        cmake \
        pkgconf \
        unzip \
        build-base \
        clang \
        clang-dev \
        zlib-dev && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache --virtual build-deps2 \
        libtbb \
        libtbb-dev && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    pip --no-cache-dir install ${PYTHON_XATTR_PACKAGE} && \
    CC="/usr/bin/clang" && \
    CXX="/usr/bin/clang++" && \
    LIBRARY_PATH="/lib:/usr/lib" && \
    pip --no-cache-dir install cython && \
    pip --no-cache-dir install numpy && \
    apk del build-deps1 && \
    apk del build-deps2 && \
    cat /etc/apk/repositories.bak > /etc/apk/repositories && \
    apk add --no-cache --virtual openstack-common-deps  \
        libxml2 \
        libxslt \
        libcurl \
        openssl

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
