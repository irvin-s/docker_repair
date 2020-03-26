FROM alpine:latest AS builder  
LABEL maintainer="dochang@gmail.com"  
  
ENV SHADOWSOCKS_LIBEV_VERSION=v3.1.3  
ENV SHADOWSOCKS_LIBEV_PKG=github.com/shadowsocks/shadowsocks-libev  
ENV SHADOWSOCKS_LIBEV_REPO=https://$SHADOWSOCKS_LIBEV_PKG.git  
ENV SHADOWSOCKS_LIBEV_SRC=/usr/local/src/$SHADOWSOCKS_LIBEV_PKG  
  
RUN apk add --no-cache --virtual .build-deps \  
git \  
autoconf \  
automake \  
libtool \  
build-base \  
libev-dev \  
linux-headers \  
libsodium-dev \  
mbedtls-dev \  
pcre-dev \  
c-ares-dev  
  
RUN git clone \--recursive --branch $SHADOWSOCKS_LIBEV_VERSION \  
$SHADOWSOCKS_LIBEV_REPO $SHADOWSOCKS_LIBEV_SRC  
  
WORKDIR $SHADOWSOCKS_LIBEV_SRC  
  
RUN ./autogen.sh  
RUN ./configure --prefix=/usr/local \--disable-documentation  
RUN make install  
  
FROM dochang/confd:latest  
LABEL maintainer="dochang@gmail.com"  
  
COPY \--from=builder /usr/local/bin/* /usr/local/bin/  
  
RUN apk add --no-cache --virtual .run-deps \  
rng-tools \  
c-ares \  
libev \  
libsodium \  
mbedtls \  
pcre \  
musl  
  
VOLUME ["/etc/shadowsocks"]  
COPY entrypoint.sh /  
ENTRYPOINT ["/entrypoint.sh"]  

