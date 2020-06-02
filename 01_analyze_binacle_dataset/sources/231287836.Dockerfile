FROM strato-build

ENV VERSION 1.6.0
ENV LDFLAGS -s
RUN wget -P /usr/src/ http://ftp.netfilter.org/pub/iptables/iptables-${VERSION}.tar.bz2
RUN cd /usr/src/ && tar xf iptables*
RUN cd /usr/src/iptables* \
    && ./configure \
    --prefix=/usr \
    --mandir=/usr/share/man \
    --sbindir=/sbin \
    --without-kernel \
    --enable-devel \
    --enable-libipq \
    --enable-shared \
    && make

RUN cd /usr/src/iptables* \
    && make install
