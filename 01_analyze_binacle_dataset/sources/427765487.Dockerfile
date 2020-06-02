# Creates an image for skycoin development with Python tools installed
ARG IMAGE_FROM=skycoin/skycoindev-cli:develop
FROM $IMAGE_FROM

ARG BDATE
ARG SCOMMIT
ARG PIP_PACKAGES="setuptools wheel"

# Image labels (see ./hooks/build for ARGS)
LABEL "org.label-schema.name"="skycoindev-python" \
      "org.label-schema.description"="Docker image with go, node, python and dev tools for Skycoin developers" \
      "org.label-schema.vendor"="Skycoin project" \
      "org.label-schema.url"="skycoin.net" \
      "org.label-schema.version"="0.24.4" \
      "org.label-schema.build-date"=$BDATE \
      "org.label-schema.vcs-url"="https://github.com/skycoin/pyskycoin.git" \
      "org.label-schema.vcs-ref"=$SCOMMIT \
      "org.label-schema.usage"="https://github.com/skycoin/pyskycoin/blob/"$SCOMMIT"/docker/images/dev/README.md" \
      "org.label-schema.schema-version"="1.0" \
      "org.label-schema.docker.cmd"="mkdir src; docker run --rm -v ${PWD}/src:/usr/local/src skycoin/skycoindev-python:develop git clone https://github.com/simelo/pyskycoin.git"

# Install Python 2.7/3.5 runtime and development tools
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
		python2.7-dev \
		python3.5 \
		python3.5-dev \
		python-dev \
		python3-dev \
		ca-certificates \
		libexpat1 \
		libffi6 \
		libgdbm3 \
		libreadline7 \
		libsqlite3-0 \
		libssl1.1 \
		netbase \
		wget \
		python-pip \
		python3-pip \
    && pip install --upgrade pip \
    && pip3 install --upgrade pip

# Install Python 3.7
# runtime dependencies
ENV PYTHON_VERSION 3.7.1
RUN set -ex \
	&& buildDeps=" \
		libexpat1-dev \
		tcl-dev \
		tk-dev \
    # as of Stretch, "gpg" is no longer included by default
		$(command -v gpg > /dev/null || echo 'gnupg dirmngr') \
	" \
	&& apt-get install -y $buildDeps --no-install-recommends \
	\
	&& wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
	&& wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& for server in ha.pool.sks-keyservers.net \
              hkp://p80.pool.sks-keyservers.net:80 \
              keyserver.ubuntu.com \
              hkp://keyserver.ubuntu.com:80 ;do\
	      gpg --keyserver "$server" --recv-keys 0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D;done \
	&& gpg --batch --verify python.tar.xz.asc python.tar.xz \
	&& rm -rf "$GNUPGHOME" python.tar.xz.asc \
	&& mkdir -p /usr/src/python \
	&& tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
	&& rm python.tar.xz \
	\
	&& cd /usr/src/python \
	&& gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
	&& ./configure \
        --prefix=/usr \
		--build="$gnuArch" \
		--enable-loadable-sqlite-extensions \
		--enable-shared \
		--with-system-expat \
		--with-system-ffi \
		--without-ensurepip \
	&& make -j "$(nproc)" \
	&& make altinstall \
	&& ldconfig \
	\
	&& find /usr/local -depth \
		\( \
			\( -type d -a \( -name test -o -name tests \) \) \
			-o \
			\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
		\) -exec rm -rf '{}' + \
	&& rm -rf /usr/src/python

# Install Python 3.6
# runtime dependencies
ENV PYTHON_VERSION 3.6.7
RUN set -ex \
	&& buildDeps=" \
		libexpat1-dev \
		tcl-dev \
		tk-dev \
    # as of Stretch, "gpg" is no longer included by default
		$(command -v gpg > /dev/null || echo 'gnupg dirmngr') \
	" \
	&& apt-get install -y $buildDeps --no-install-recommends \
	\
	&& wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
	&& wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& for server in ha.pool.sks-keyservers.net \
              hkp://p80.pool.sks-keyservers.net:80 \
              keyserver.ubuntu.com \
              hkp://keyserver.ubuntu.com:80 ;do\
	      gpg --keyserver "$server" --recv-keys 0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D;done \
	&& gpg --batch --verify python.tar.xz.asc python.tar.xz \
	&& rm -rf "$GNUPGHOME" python.tar.xz.asc \
	&& mkdir -p /usr/src/python \
	&& tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
	&& rm python.tar.xz \
	\
	&& cd /usr/src/python \
	&& gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
	&& ./configure \
        --prefix=/usr \
		--build="$gnuArch" \
		--enable-loadable-sqlite-extensions \
		--enable-shared \
		--with-system-expat \
		--with-system-ffi \
		--without-ensurepip \
	&& make -j "$(nproc)" \
	&& make altinstall \
	&& ldconfig \
	\
	&& find /usr/local -depth \
		\( \
			\( -type d -a \( -name test -o -name tests \) \) \
			-o \
			\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
		\) -exec rm -rf '{}' + \
	&& rm -rf /usr/src/python

# Install Python 3.4
# runtime dependencies
ENV PYTHON_VERSION 3.4.9
RUN set -ex \
	&& buildDeps=" \
# as of Stretch, "gpg" is no longer included by default
		$(command -v gpg > /dev/null || echo 'gnupg dirmngr') \
	" \
	&& apt-get install -y libssl1.0-dev $buildDeps --no-install-recommends \
	\
	&& wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
	&& wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& for server in ha.pool.sks-keyservers.net \
              hkp://p80.pool.sks-keyservers.net:80 \
              keyserver.ubuntu.com \
              hkp://keyserver.ubuntu.com:80 ;do\
	      gpg --keyserver "$server" --recv-keys 97FC712E4C024BBEA48A61ED3A5CA953F73C700D;done \
	&& gpg --batch --verify python.tar.xz.asc python.tar.xz \
	&& rm -rf "$GNUPGHOME" python.tar.xz.asc \
	&& mkdir -p /usr/src/python \
	&& tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
	&& rm python.tar.xz \
	\
	&& cd /usr/src/python \
	&& gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
	&& ./configure \
        --prefix=/usr \
		--build="$gnuArch" \
		--enable-loadable-sqlite-extensions \
		--enable-shared \
		--with-system-expat \
		--with-system-ffi \
		--without-ensurepip \
	&& make -j "$(nproc)" \
	&& make altinstall \
	&& ldconfig \
	\
    && apt-get install -y libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
	\
	&& find /usr/local -depth \
		\( \
			\( -type d -a \( -name test -o -name tests \) \) \
			-o \
			\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
		\) -exec rm -rf '{}' + \
	&& rm -rf /usr/src/python

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 18.1
RUN set -ex; \
	\
	wget -O get-pip.py 'https://bootstrap.pypa.io/get-pip.py'; \
	\
	python3.7 get-pip.py \
		--disable-pip-version-check \
		--no-cache-dir \
		"pip==$PYTHON_PIP_VERSION" \
	; \
	python3.6 get-pip.py \
		--disable-pip-version-check \
		--no-cache-dir \
		"pip==$PYTHON_PIP_VERSION" \
	; \
    python3.5 get-pip.py \
		--disable-pip-version-check \
		--no-cache-dir \
		"pip==$PYTHON_PIP_VERSION" \
	; \
    python3.4 get-pip.py \
		--disable-pip-version-check \
		--no-cache-dir \
		"pip==$PYTHON_PIP_VERSION" \
	; \
	find /usr/local -depth \
		\( \
			\( -type d -a \( -name test -o -name tests \) \) \
			-o \
			\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
		\) -exec rm -rf '{}' +; \
	rm -f get-pip.py

# Install packages in PIP_PACKAGES
RUN pip install --upgrade $PIP_PACKAGES \
    && pip3 install --upgrade $PIP_PACKAGES \
    &&  python3.4 -m pip install --upgrade $PIP_PACKAGES \
    &&  python3.6 -m pip install --upgrade $PIP_PACKAGES \
    &&  python3.7 -m pip install --upgrade $PIP_PACKAGES

WORKDIR $GOPATH/src/github.com/skycoin

VOLUME $GOPATH/src/
