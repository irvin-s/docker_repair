FROM buildpack-deps:jessie-curl
#FROM debian:stretch-slim

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		netbase \
	&& rm -rf /var/lib/apt/lists/*

RUN set -ex \
	\
	&& savedAptMark="$(apt-mark showmanual)" \
	&& apt-get update && apt-get install -y --no-install-recommends \
		dpkg-dev \
		gcc \
		libbz2-dev \
		libc6-dev \
		libexpat1-dev \
		libffi-dev \
		libgdbm-dev \
		liblzma-dev \
		libncursesw5-dev \
		libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
		make \
		tk-dev \
		uuid-dev \
		wget \
		xz-utils \
		zlib1g-dev \
# as of Stretch, "gpg" is no longer included by default
		$(command -v gpg > /dev/null || echo 'gnupg dirmngr')


RUN wget -O openssl.tar.gz "https://www.openssl.org/source/openssl-1.1.1.tar.gz" \
 && mkdir -p /usr/src/openssl \
 && tar -xvzC /usr/src/openssl --strip-components=1 -f openssl.tar.gz 

RUN cd /usr/src/openssl \
 && mkdir -p /usr/local/openssl \
 && ./config --prefix=/usr/local/openssl \
 && make \
 && make install 


RUN mkdir -p /usr/local/python/3.7.0/src && mkdir /usr/local/python/3.7.0/bin && mkdir -p  /usr/local/python/3.7.0/lib

WORKDIR /usr/local/python/3.7.0/src
ENV PYTHON_VERSION=3.7.0
ENV GPG_KEY=0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D
ENV PIP_VERSION=18.0


RUN set -ex \
        && buildDeps=' \
                dpkg-dev \
                tcl-dev \
                tk-dev \
        ' \
        && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
        \
        && wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
        && wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
        && export GNUPGHOME="$(mktemp -d)" \
        && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
        && gpg --batch --verify python.tar.xz.asc python.tar.xz \
        && rm -rf "$GNUPGHOME" python.tar.xz.asc \
        && mkdir -p /usr/src/python \
        && tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
        && rm python.tar.xz \
        \
        && cd /usr/src/python \
        && gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
        && ./configure \
                --prefix=/usr/local/python/3.7.0 \
                --build="$gnuArch" \
                --enable-loadable-sqlite-extensions \
                --enable-shared \
                --with-system-expat \
                --with-system-ffi \
                --without-ensurepip  \
                --with-openssl=/usr/local/openssl \
                LDFLAGS="-L/usr/local/python/${PYTHON_VERSION}/extlib/lib -Wl,--rpath=/usr/local/python/${PYTHON_VERSION}/lib -Wl,--rpath=/usr/local/python/${PYTHON_VERSION}/extlib/lib -Wl,--rpath=/usr/local/openssl/lib" \
        && make -j "$(nproc)" \
        && make install \
        && ldconfig \
        \
#        && apt-get purge -y --auto-remove $buildDeps \
        \
        && find /usr/local -depth \
                \( \
                        \( -type d -a \( -name test -o -name tests \) \) \
                        -o \
                        \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
                \) -exec rm -rf '{}' + 
#        && rm -rf /usr/src/python


ENV PYTHON_PATH=/usr/local/python/$PYTHON_VERSION
ENV PATH=$PYTHON_PATH/bin:$PATH

ENV PYTHON_PIP_VERSION=18.0
RUN set -ex; \
        \
        wget -O get-pip.py 'https://bootstrap.pypa.io/get-pip.py'; \
        \
        python3 get-pip.py \
                --disable-pip-version-check \
                --no-cache-dir \
                "pip==$PYTHON_PIP_VERSION" \
        ; \
        pip --version; \
        \
        find /usr/local -depth \
                \( \
                        \( -type d -a \( -name test -o -name tests \) \) \
                        -o \
                        \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
                \) -exec rm -rf '{}' +; \
        rm -f get-pip.py


RUN pip3 install virtualenv

