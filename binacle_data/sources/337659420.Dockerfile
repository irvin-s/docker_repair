FROM alpine:3.7 AS build

LABEL maintainer "Balloo <flint@kraflink.com>"

WORKDIR /src

ADD . cryply

RUN apk add --no-cache \
      alpine-sdk autoconf libtool automake boost-dev openssl-dev db-dev git \
      && cd cryply            \
      && ./autogen.sh         \
      && ./configure          \
      --enable-upnp-default   \
      --without-gui           \
      --disable-tests         \
      --with-incompatible-bdb \
      && make -j$(nproc)      \
      && make install

FROM alpine:3.7

COPY --from=build /usr/local/bin/cryplyd    /usr/local/bin/cryplyd
COPY --from=build /usr/local/bin/cryply-cli /usr/local/bin/cryply-cli

RUN apk add --no-cache db-c++ boost boost-program_options openssl

ADD ./contrib/entrypoint.sh /

WORKDIR /data

VOLUME ["/data"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["cryplyd"]
