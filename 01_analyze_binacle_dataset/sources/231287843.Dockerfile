FROM strato-build
RUN strato add xz-dev

ENV VERSION 23
ENV LDFLAGS -s
RUN wget -P /usr/src/ http://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-${VERSION}.tar.xz
RUN cd /usr/src/ && tar xf kmod*
RUN cd /usr/src/kmod* \
    && ./configure \
    --prefix=/usr \
    --bindir=/bin \
    --sysconfdir=/etc \
    --with-rootlibdir=/lib \
    --with-zlib \
    --with-xz \
    && make

RUN cd /usr/src/kmod* \
    && make install \
    && for i in lsmod rmmod insmod modinfo modprobe depmod; do [ -e /bin/$i ] && rm /bin/$i; ln -s kmod /bin/$i; done \
    && for i in lsmod modinfo; do [ -e /bin/$i ] && rm /bin/$i; ln -s kmod "$pkgdir"/bin/$i; done
