FROM strato-build

ENV VERSION 2.02.168
ENV LDFLAGS -s
RUN wget -P /usr/src/ https://mirrors.kernel.org/sourceware/lvm2/LVM2.${VERSION}.tgz
RUN cd /usr/src/ && tar xf LVM2*
RUN cd /usr/src/LVM2* \
    && ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --libdir=/lib \
    --sbindir=/sbin \
    --localstatedir=/var \
    --disable-nls \
    --disable-readline \
    --enable-pkgconfig \
    --enable-applib \
    --with-thin=internal \
    --enable-dmeventd \
    --enable-cmdlib \
    --with-thin-check=/sbin/thin_check \
    --with-thin-dump=/sbin/thin_dump \
    --with-thin-repair=/sbin/thin_repair \
    --with-dmeventd-path=/sbin/dmeventd \
    && make

RUN cd /usr/src/LVM2* \
    && make install
