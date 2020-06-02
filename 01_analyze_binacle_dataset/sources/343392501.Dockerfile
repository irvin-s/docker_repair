FROM lalyos/alpine-build:edge

RUN apk add -U zlib-dev xz-dev curl perl

ENV LDFLAGS=-static

ENV UCL_VER 1.03
RUN curl -L http://www.oberhumer.com/opensource/ucl/download/ucl-${UCL_VER}.tar.gz|tar -xzv \
    && cd ucl-${UCL_VER} \
    && ./configure \
    && make \
    && make install

ENV LZMA_VER 920
RUN curl -LO http://www.7-zip.org/a/lzma${LZMA_VER}.tar.bz2 \
    && bunzip2 lzma${LZMA_VER}.tar.bz2 \
    && tar -xvf lzma${LZMA_VER}.tar
ENV UPX_LZMADIR /

VOLUME /release

ENV UPX_UCLDIR=/ucl-${UCL_VER}
ENV UPX_VER 3.91
RUN curl -LO http://upx.sourceforge.net/download/upx-${UPX_VER}-src.tar.bz2 \
    && bunzip2 upx-${UPX_VER}-src.tar.bz2  \
    && tar -xvf upx-${UPX_VER}-src.tar \
    && cd upx-${UPX_VER}-src \
    && sed -i "/addLoad/ s/NULL/(char*)NULL/" src/packer.cpp \
    && make all

# packs itself
CMD /upx-${UPX_VER}-src/src/upx.out --best --ultra-brute -o/release/upx /upx-${UPX_VER}-src/src/upx.out



