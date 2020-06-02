FROM alpine:3.3

ENV NODEJS_VERSION=5.7.0 \
    NODEJS_SHA256=2338b46a2f45fbb747089c66931f62555f25a5928511d3a43bbb3a39dcded2d8 \
    NPM_VERSION=3.7.3

RUN info(){ printf '\n--\n%s\n--\n\n' "$*"; } \
 && info "==> Installing build dependencies..." \
 && apk update \
 && apk add --virtual build-deps \
    curl make gcc g++ python paxctl \
    musl-dev openssl-dev zlib-dev \
    linux-headers binutils-gold \
 && mkdir -p /root/nodejs \
 && cd /root/nodejs \
 && info "==> Downloading..." \
 && curl -sSL -o node.tar.gz http://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}.tar.gz \
 && echo "$NODEJS_SHA256  node.tar.gz" > node.sha256 \
 && sha256sum -c node.sha256 \
 && info "==> Extracting..." \
 && tar -xzf node.tar.gz \
 && cd node-* \
 && info "==> Configuring..." \
 && readonly NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || echo 1) \
 && echo "using upto $NPROC threads" \
 && ./configure \
   --prefix=/usr \
   --shared-openssl \
   --shared-zlib \
 && info "==> Building..." \
 && make -j$NPROC -C out mksnapshot \
 && paxctl -c -m out/Release/mksnapshot \
 && make -j$NPROC \
 && info "==> Installing..." \
 && make install \
 && info "==> Removing build dependencies..." \
 && apk del build-deps \
 && apk add \
    openssl libgcc libstdc++ \
 && info "==> Updating NPM..." \
 && npm i -g npm@$NPM_VERSION \
 && info "==> Cleaning up..." \
 && npm cache clean \
 && rm -rf ~/.node-gyp /tmp/* /usr/share/man /var/cache/apk/* \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc \
    /usr/lib/node_modules/npm/html /root/nodejs \
 && echo 'Done! =)'
