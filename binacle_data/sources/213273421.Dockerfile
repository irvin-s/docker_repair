FROM buildpack-deps:jessie


# ############
# unprivileged
# ############

# explicitly set user/group IDs
RUN groupadd -r unprivileged --gid=999 && useradd -m -r -g unprivileged --uid=999 unprivileged

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN set -x \
	&& apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true


# ####
# NODE 6.2 at https://github.com/nodejs/docker-node/blob/dc9ceb77ad6d98258c825ee45aac219169bc3532/6.2/Dockerfile
# ####

# gpg keys listed at https://github.com/nodejs/node
RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 6.2.2

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt


# ######
# PYTHON 3.5 at https://github.com/docker-library/python/blob/9383f7d4d2f96068e8957651aa3588fee8b48f71/3.5/Dockerfile
# ######

# remove several traces of debian python
#RUN apt-get purge -y python.*

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# gpg: key F73C700D: public key "Larry Hastings <larry@hastings.org>" imported
ENV GPG_KEY 97FC712E4C024BBEA48A61ED3A5CA953F73C700D

ENV PYTHON_VERSION 3.5.1

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 8.1.2

RUN set -ex \
	&& curl -fSL "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" -o python.tar.xz \
	&& curl -fSL "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" -o python.tar.xz.asc \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
	&& gpg --batch --verify python.tar.xz.asc python.tar.xz \
	&& rm -r "$GNUPGHOME" python.tar.xz.asc \
	&& mkdir -p /usr/src/python \
	&& tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
	&& rm python.tar.xz \
	\
	&& cd /usr/src/python \
	&& ./configure --enable-shared --enable-unicode=ucs4 \
	&& make -j$(nproc) \
	&& make install \
	&& ldconfig \
	&& pip3 install --no-cache-dir --upgrade --ignore-installed pip==$PYTHON_PIP_VERSION \
	&& find /usr/local -depth \
		\( \
		    \( -type d -a -name test -o -name tests \) \
		    -o \
		    \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		\) -exec rm -rf '{}' + \
	&& rm -rf /usr/src/python ~/.cache \
	&& cd /usr/local/bin \
	&& ln -s easy_install-3.5 easy_install3 \
	&& ln -s python3 python

#	&& ln -s idle3 idle \
#	&& ln -s pydoc3 pydoc \
#	&& ln -s python3-config python-config


# ######
# DJANGO + PILLOW
# ######

# https://github.com/docker-library/django/blob/819c332058c3638ab8f4fa5b9f70518e9aaf6325/3.4/Dockerfile
# http://pillow.readthedocs.io/en/3.1.x/installation.html#building-on-linux
RUN apt-get update && apt-get install -y \
        gcc gettext \
        mysql-client libmysqlclient-dev \
        postgresql-client libpq-dev sqlite3 \
        libtiff5-dev libjpeg62-turbo-dev zlib1g-dev libfreetype6-dev \
        liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev \
        libxml2-dev libxslt-dev libffi-dev \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir --upgrade gunicorn psycopg2 mysqlclient virtualenv invoke Jinja2 Pillow

RUN npm install -g bower && npm install -g gulp

# #######
# PROJECT
# #######

ENV PYTHONUNBUFFERED 1

RUN mkdir -p /app /static /media /cache && chown -R unprivileged:unprivileged /media /cache
WORKDIR /app

COPY requirements.txt /requirements.txt
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN pip3 install --no-cache-dir -r /requirements.txt

ENV STATIC_ROOT /static
ENV MEDIA_DIR /media
ENV DATA_DIR /cache

COPY . /app
RUN /app/docker-prepare.sh

EXPOSE 8000
VOLUME ["/static", "/media", "/cache", "/app"]
ENTRYPOINT ["/docker-entrypoint.sh"]
