FROM strato-build
RUN strato add xz-dev

ENV VERSION 3.2
ENV LDFLAGS -s
RUN wget -P /usr/src/ ftp://ftp.gnu.org/pub/gnu/parted/parted-${VERSION}.tar.xz
COPY parted-3.2-device-mapper.patch /usr/src/
RUN cd /usr/src && tar xf parted*.xz
RUN cd /usr/src/parted* && patch -p1 < ../parted-3.2-device-mapper.patch
RUN cd /usr/src/parted* \
    && ./configure \
    --prefix=/usr \
    --disable-debug \
    --disable-nls \
    --disable-device-mapper \
    --without-readline \
    --disable-static \
    --enable-shared \
    && make

RUN cd /usr/src/parted* \
    && make install
