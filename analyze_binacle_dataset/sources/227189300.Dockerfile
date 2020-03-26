FROM sourceryinstitute/docker-base:latest

MAINTAINER Izaak "Zaak" Beekman <contact@izaakbeekman.com>

ENV REFRESHED_AT 2016-12-07
COPY NOTICE /NOTICE

# Build-time metadata as defined at http://label-schema.org
    ARG BUILD_DATE
    ARG VCS_REF
    ARG VCS_URL
    ARG VCS_VERSION=latest
    LABEL org.label-schema.schema-version="1.0" \
    	  org.label-schema.build-date="$BUILD_DATE" \
          org.label-schema.name="nightly-gcc-trunk-docker-image" \
          org.label-schema.description="Nightly builds of GCC trunk using docker" \
          org.label-schema.url="https://github.com/zbeekman/nightly-gcc-trunk-docker-image/" \
          org.label-schema.vcs-ref="$VCS_REF" \
          org.label-schema.vcs-url="$VCS_URL" \
	  org.label-schema.version="$VCS_VERSION" \
          org.label-schema.vendor="zbeekman" \
          org.label-schema.license="GPL-3.0" \
          org.label-schema.docker.cmd="docker run -v $(pwd):/virtual/path -i -t zbeekman/nightly-gcc-trunk-docker-image"



RUN DEBIAN_FRONTEND=noninteractive transientBuildDeps="dpkg-dev apt-utils bison flex libmpc-dev" \
    && set -v \
    && printf "\
        nightly-gcc-trunk-docker-image  Copyright (C) 2016  Izaak B. Beekman\n\
        This program comes with ABSOLUTELY NO WARRANTY.\n\
        This is free software, and you are welcome to redistribute it\n\
        under certain conditions.\n\
        \n\
        see https://github.com/zbeekman/nightly-gcc-trunk-docker-image/blob/master/LICENSE for the full GPL-v3 license\n\n\n" > /etc/motd \
    && echo "$DEBIAN_FRONTEND" "$transientBuildDeps" \
    && apt-get update \
    && apt-get install -y $transientBuildDeps libisl-dev --no-install-recommends --no-install-suggests \
    && git clone --depth=1 --single-branch --branch master git://gcc.gnu.org/git/gcc.git gcc \
    && cd gcc \
    && mkdir objdir \
    && cd objdir \
    && ../configure --enable-languages=c,c++,fortran --disable-multilib \
       --disable-bootstrap --build=x86_64-linux-gnu \
    && make -j"$(nproc)" \
    && make install-strip \
    && make distclean \
    && cd ../.. \
    && rm -rf ./gcc \
    && echo '/usr/local/lib64' > /etc/ld.so.conf.d/local-lib64.conf \
    && ldconfig -v\
    && dpkg-divert --divert /usr/bin/gcc.orig --rename /usr/bin/gcc \
    && dpkg-divert --divert /usr/bin/g++.orig --rename /usr/bin/g++ \
    && dpkg-divert --divert /usr/bin/gfortran.orig --rename /usr/bin/gfortran \
    && update-alternatives --install /usr/bin/cc cc /usr/local/bin/gcc 999 \
    && apt-get purge -y --auto-remove $transientBuildDeps \
    && rm -rf /var/lib/apt/lists/* /var/log/* /tmp/*

ENTRYPOINT ["/bin/bash"]

CMD ["-l"]
