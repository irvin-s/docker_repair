ARG SRS_VERSION=3.0.42

FROM debian:jessie AS build

ARG SRS_VERSION
ENV SRS_VERSION=${SRS_VERSION}
ENV SRS_COMMIT=5945fb5a244eabb2431953eba381efea8c8448d5
ENV SRS_CONFIGURE_ARGS=--with-ffmpeg

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends wget ca-certificates sudo python net-tools libfile-spec-native-perl; \
    cd /tmp; \
    wget https://github.com/ossrs/srs/archive/${SRS_COMMIT}.tar.gz; \
    tar zxf ${SRS_COMMIT}.tar.gz; \
    cd srs-${SRS_COMMIT}/trunk; \
    ./configure --prefix=/srs ${SRS_CONFIGURE_ARGS}; \
    make; \
    make install; \
    cp -HR objs/ffmpeg /srs/objs/; \
    rm -rf /tmp/*; \
    rm -rf /var/lib/apt/lists/*;
COPY ./srs.conf /srs/conf/docker.conf

FROM debian:jessie-slim AS dist
ARG SRS_VERSION
ENV SRS_VERSION=${SRS_VERSION}
EXPOSE 1935 1985 8080
COPY --from=build /srs /srs
WORKDIR /srs
CMD ["./objs/srs", "-c", "./conf/docker.conf"]
