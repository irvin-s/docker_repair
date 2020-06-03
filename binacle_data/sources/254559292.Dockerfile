# based on https://github.com/newsdev/docker-varnish
FROM debian:jessie

RUN \
  useradd -r -s /bin/false varnishd

# Install Varnish source build dependencies
RUN \
  apt-get update && apt-get install -y --no-install-recommends \
    automake \
    build-essential \
    ca-certificates \
    curl \
    libedit-dev \
    libjemalloc-dev \
    libncurses-dev \
    libpcre3-dev \
    libtool \
    pkg-config \
    python-docutils \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Varnish from source, so that Varnish modules
# can be compiled and installed
ENV VARNISH_VERSION=4.1.0
ENV VARNISH_SHA256SUM=4a6ea08e30b62fbf25f884a65f0d8af42e9cc9d25bf70f45ae4417c4f1c99017
RUN \
  apt-get update && \
  mkdir -p /usr/local/src && \
  cd /usr/local/src && \
  curl -sfLO https://repo.varnish-cache.org/source/varnish-$VARNISH_VERSION.tar.gz && \
  echo "${VARNISH_SHA256SUM} varnish-$VARNISH_VERSION.tar.gz" | sha256sum -c - && \
  tar -xzf varnish-$VARNISH_VERSION.tar.gz && \
  cd varnish-$VARNISH_VERSION && \
  ./autogen.sh && \
  ./configure && \
  make install && \
  rm ../varnish-$VARNISH_VERSION.tar.gz

# varnishd(1) options
ENV VARNISH_VCL_PATH /etc/varnish/default.vcl
ENV VARNISH_PORT 80
ENV VARNISH_MEMORY 64m

# VMOD options
ENV QUERYSTRING_VERSION 0.3

# varnishlog(1) options
ENV VARNISHLOG_PATH /etc/varnish/log.log

# varnishncsa(1) options
ENV VARNISHNCSA_FORMAT_PATH /etc/varnishncsa/varnishncsa-format.txt
ENV VARNISHNCSA_LOG_PATH /var/log/varnish/access.log

COPY varnish/start-varnish.sh /usr/local/bin/start-varnish
COPY varnish/install-querystring.sh /usr/local/bin/install-querystring
COPY varnish/varnishncsa-format.txt /etc/varnishncsa/varnishncsa-format.txt

# install VMODs
RUN \
  install-querystring

# forward logs to docker log collector
RUN \
  mkdir -p $(dirname ${VARNISHNCSA_LOG_PATH}) && \
  mkdir -p $(dirname ${VARNISHLOG_PATH}) && \
  touch ${VARNISHLOG_PATH} ${VARNISHNCSA_LOG_PATH} && \
  ln -sf /dev/stdout ${VARNISHLOG_PATH} && \
  ln -sf /dev/stdout ${VARNISHNCSA_LOG_PATH}

EXPOSE 80
CMD [ "start-varnish" ]

ONBUILD COPY varnish/default.vcl /etc/varnish/default.vcl
