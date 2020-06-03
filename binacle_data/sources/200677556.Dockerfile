# This Dockerfile is soley intented for running automated tests in an environment
# that is nearly identical to the deployed Docker environment.

FROM alpine:3.4
MAINTAINER Elijah Zupancic <elijah@zupancic.name>

ENV TZ=utc
ENV NODE_VERSION=4.5.0

# Copy the application
RUN mkdir -p /home/app/tmp
COPY docker/usr/local/bin/proclimit.sh /usr/local/bin/proclimit.sh

RUN chmod +x /usr/local/bin/proclimit.sh \
     && apk upgrade --update \
     && apk add curl make gcc g++ linux-headers paxctl musl-dev git \
        libgcc libstdc++ binutils-gold python openssl-dev zlib-dev \
     && mkdir -p /root/src

# Enable to download already built node and just install it. The actual
# production image will fully build it, but for the testing image we download
# an already compiled version and install it because it makes the whole process
# go faster.
RUN cd /root/src \
    && curl -sSL https://us-east.manta.joyent.com/elijah.zupancic/public/s3-manta-bridge/node-v${NODE_VERSION}-x64-musl.tar.xz > /tmp/node-v${NODE_VERSION}-x64-musl.tar.xz \
    && echo "97e60a7cba1f7a2e00a768fa597a1cfe738b335295f010f7a3dfbc7854278249  /tmp/node-v${NODE_VERSION}-x64-musl.tar.xz" | sha256sum -c \
    && unxz -c /tmp/node-v${NODE_VERSION}-x64-musl.tar.xz | tar xf - \
    && rm -f /tmp/node-v${NODE_VERSION}-x64-musl.tar.xz

# Enable to rebuild node from scratch - use this to build another version and
# then you will manually need to create an archive and upload it to Manta.
#RUN cd /root/src \
#     && curl -sSL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}.tar.xz > /tmp/node-v${NODE_VERSION}.tar.xz \
#     && echo "97b99d378c56802444208409568e2e66c46332897f06aead74d1ffbe733bd488  /tmp/node-v${NODE_VERSION}.tar.xz" | sha256sum -c \
#     && unxz -c /tmp/node-v${NODE_VERSION}.tar.xz | tar xf - \
#     && cd /root/src/node-* \
#     && ./configure --prefix=/usr --without-snapshot \
#     && make -j$(/usr/local/bin/proclimit.sh || grep -c ^processor /proc/cpuinfo 2>/dev/null || 1)

RUN cd /root/src/node-* \
     && make install \
     && paxctl -cm /usr/bin/node \
     && npm cache clean

RUN adduser -h /home/app -s /bin/sh -D app

COPY . /home/app

RUN cd /home/app \
     && npm install \
     && find /home/app/node_modules/ -name \*.md -type f | xargs rm -rf $1 \
     && find /home/app/node_modules/ -name docs -or -name examples -type d | xargs rm -rf $1 \

# This doesn't save any space on the container, but it removes all of the files
# that would be removed in the production container.
RUN rm -rf /root/src /tmp/* /usr/share/man /var/cache/apk/* \
        /root/.npm /root/.node-gyp /usr/lib/node_modules/npm/man \
        /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html \
        /etc/ssl /usr/include /tmp/node-v${NODE_VERSION}.tar.xz


RUN chown -R app:app /home/app

USER app
WORKDIR /home/app

CMD ["/usr/bin/npm", "test"]
