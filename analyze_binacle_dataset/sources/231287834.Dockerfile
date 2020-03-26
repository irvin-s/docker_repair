FROM strato-build

ENV VERSION 4.7.0
ENV LDFLAGS -s
RUN wget -P /usr/src/ http://kernel.org/pub/linux/utils/net/iproute2/iproute2-${VERSION}.tar.xz
RUN cd /usr/src/ && tar xf iproute2*
RUN cd /usr/src/iproute2* \
    && ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --mandir=/usr/share/man \
    --localstatedir=/var \
    && make

RUN cd /usr/src/iproute2* \
    && make install
