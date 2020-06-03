# TODO: remove dependency on attr
FROM strato-build

ENV VERSION 3.1.2
ENV LDFLAGS -s
RUN wget -P /usr/src/ http://rsync.samba.org/ftp/rsync/rsync-${VERSION}.tar.gz
RUN cd /usr/src/ && tar xf rsync*
RUN cd /usr/src/rsync* \
    && ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --mandir=/usr/share/man \
    --localstatedir=/var \
    && make

RUN cd /usr/src/rsync* \
    && make install
