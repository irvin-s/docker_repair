FROM alpine:3.4
MAINTAINER Elijah Zupancic <elijah@zupancic.name>

ENV TZ=utc
ENV RUNIT_VERSION=2.1.2
ENV NODE_VERSION=4.5.0
ENV RUNSVINIT_VERSION=2.0.0

# Copy the application
RUN mkdir -p /home/app/tmp
COPY package.json /home/app/
COPY docker/usr/local/bin/proclimit.sh /usr/local/bin/proclimit.sh

RUN chmod +x /usr/local/bin/proclimit.sh \
     && apk upgrade --update \
     && apk add curl make gcc g++ linux-headers paxctl musl-dev git \
        libgcc libstdc++ binutils-gold python openssl-dev zlib-dev \
        nginx \
     && mkdir -p /root/src \
     && cd /root/src \
     && curl -sSL http://smarden.org/runit/runit-${RUNIT_VERSION}.tar.gz > /tmp/runit-${RUNIT_VERSION}.tar.gz \
     && echo "398f7bf995acd58797c1d4a7bcd75cc1fc83aa66  /tmp/runit-${RUNIT_VERSION}.tar.gz" | sha1sum -c \
     && mkdir -p /root/src/runit \
     && tar -C /root/src/runit -xzf /tmp/runit-${RUNIT_VERSION}.tar.gz \
     && cd /root/src/runit/admin/runit-${RUNIT_VERSION}/src \
     && make -j$(/usr/local/bin/proclimit.sh || grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
     && cd .. \
     && cat package/commands | xargs -I {} mv -f src/{} /sbin/ \
     && cd /root/src \
     && curl -sSL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.xz > /tmp/node-v${NODE_VERSION}.tar.xz \
     && echo "97b99d378c56802444208409568e2e66c46332897f06aead74d1ffbe733bd488  /tmp/node-v${NODE_VERSION}.tar.xz" | sha256sum -c \
     && unxz -c /tmp/node-v${NODE_VERSION}.tar.xz | tar xf - \
     && cd /root/src/node-* \
     && ./configure --prefix=/usr --without-snapshot \
     && make -j$(/usr/local/bin/proclimit.sh || grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
     && make install \
     && paxctl -cm /usr/bin/node \
     && npm cache clean \
     && adduser -h /home/app -s /bin/sh -D app \
     && cd /home/app \
     && npm install --production \
     && npm install pm2@next -g \
     && find /home/app/node_modules/ -name \*.md -type f | xargs rm -rf $1 \
     && find /home/app/node_modules/ -name docs -or -name examples -type d | xargs rm -rf $1 \
     && curl -sSL https://github.com/peterbourgon/runsvinit/releases/download/v${RUNSVINIT_VERSION}/runsvinit-linux-amd64.tgz > /tmp/runsvinit-linux-amd64.tgz \
     && echo "4b357b8eba1b9a53d6368145613012af3aa74ce56576e99bad8478f70d421d9f  /tmp/runsvinit-linux-amd64.tgz" | sha256sum -c \
     && tar -C /usr/local/bin -xzf /tmp/runsvinit-linux-amd64.tgz \
     && chmod -v +x /usr/local/bin/runsvinit \
     && apk del make gcc g++ python linux-headers git openssl-dev \
                paxctl musl-dev binutils-gold openssl-dev zlib-dev \
     && rm -rf /root/src /tmp/* /usr/share/man /var/cache/apk/* \
        /root/.npm /root/.node-gyp /usr/lib/node_modules/npm/man \
        /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html \
        /etc/ssl /usr/include \
        /tmp/node-v${NODE_VERSION}.tar.xz \
        /tmp/runit-${RUNIT_VERSION}.tar.gz

COPY lib/ /home/app/lib
COPY etc/ /home/app/etc
COPY app.js /home/app/
COPY docker/home/app/process.yml /home/app/process.yml
COPY docker/etc/ /etc
COPY docker/usr/local/bin/load_tls_env.sh /usr/local/bin/load_tls_env.sh
COPY docker/init /init

RUN chown -R app:app /home/app \
    && chmod -v +x /usr/local/bin/load_tls_env.sh \
    && chmod -v +x /init \
    && chmod -v +x /etc/service/nginx/run \
    && chmod -v +x /etc/service/pm2/run \
    && mkdir -p /etc/nginx/sites-enabled \
    && ln -s /etc/service /service \
    && ln -s /etc/nginx/sites-available/s3-manta-bridge.conf /etc/nginx/sites-enabled/s3-manta-bridge.conf

EXPOSE 80
EXPOSE 443

CMD ["/init"]
