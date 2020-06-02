FROM strato-build

ENV VERSION 5.2.2
ENV LDFLAGS -s
RUN wget -P /usr/src/ http://tukaani.org/xz/xz-${VERSION}.tar.gz
RUN cd /usr/src/ && tar xf xz*
RUN cd /usr/src/xz* \
    && ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --mandir=/usr/share/man \
    --infodir=/usr/share/info \
    --localstatedir=/var \
    --disable-rpath \
    --disable-werror \
    && make

RUN cd /usr/src/xz* \
    && make install
