FROM alpine:3.10.0
MAINTAINER Hypothes.is Project and Ilya Kreymer

# Install runtime deps.
RUN apk add --update \
    git \
    collectd \
    collectd-disk \
    libffi \
    openssl \
    supervisor \
    squid \
  && rm -rf /var/cache/apk/*

# Create the via user, group, home directory and package directory.
RUN addgroup -S via && adduser -S -G via -h /var/lib/via via
WORKDIR /var/lib/via

ADD requirements.txt .

# Install goreplay
RUN apk add curl \
  && curl -o /tmp/gor.tar.gz -L 'https://github.com/buger/goreplay/releases/download/v0.16.1/gor_0.16.1_x64.tar.gz' \
  && tar -xzf /tmp/gor.tar.gz -C /usr/local/bin \
  && rm /tmp/gor.tar.gz

# Install build deps, build, and then clean up.
RUN apk add --update --virtual build-deps \
    build-base \
    git \
    libffi-dev \
    linux-headers \
    openssl-dev \
    python2 \
    python2-dev \
    py2-pip \
  && pip install --no-cache-dir -U pip \
  && pip install --no-cache-dir -r requirements.txt \
  && apk del build-deps \
  && rm -rf /var/cache/apk/*

# Copy collectd config
COPY conf/collectd.conf /etc/collectd/collectd.conf
RUN mkdir /etc/collectd/collectd.conf.d \
 && chown via:via /etc/collectd/collectd.conf.d

# Copy squid config
COPY conf/squid.conf /etc/squid/squid.conf
RUN mkdir /var/spool/squid \
 && chown via:via /var/run/squid /var/spool/squid /var/log/squid

# Use local squid by default
ENV HTTP_PROXY http://localhost:3128
ENV HTTPS_PROXY http://localhost:3128

# Install app.
COPY . .

EXPOSE 9080

CMD ["supervisord", "-c" , "conf/supervisord.conf"]
