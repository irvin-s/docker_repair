FROM strato-build

ENV VERSION 1.43.3
RUN wget -P /usr/src/ https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v${VERSION}/e2fsprogs-${VERSION}.tar.xz
RUN cd /usr/src/ && tar xf e2fsprogs*
ENV LDFLAGS -s
RUN cd /usr/src/e2fsprogs* \
    && ./configure \
    --mandir=/usr/share/man \
    --enable-elf-shlibs \
    --enable-symlink-install \
    --disable-fsck \
    --disable-uuidd \
    --disable-libuuid \
    --disable-libblkid \
    --disable-tls \
    --disable-nls \
    && make

RUN cd /usr/src/e2fsprogs* \
    && make install install-libs \
