FROM strato-build

ENV VERSION 3.2
ENV LDFLAGS -s
RUN wget -P /usr/src/ http://dev.gentoo.org/~blueness/eudev/eudev-${VERSION}.tar.gz
RUN cd /usr/src/ && tar xf eudev*
RUN cd /usr/src/eudev* \
    && ./configure \
    --sysconfdir=/etc \
    --with-rootprefix= \
    --with-rootrundir=/run \
    --with-rootlibexecdir=/lib/udev \
    --libdir=/usr/lib \
    --enable-split-usr \
    --enable-manpages \
    --disable-hwdb \
    --enable-kmod \
    --exec-prefix=/ \
    && make

RUN cd /usr/src/eudev* \
    && make sharepkgconfigdir=/usr/lib/pkgconfig install
