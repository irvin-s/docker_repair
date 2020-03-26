FROM strato-build

ENV VERSION 1.8.18p1
ENV LDFLAGS -s
RUN wget -P /usr/src/ https://www.sudo.ws/dist/sudo-${VERSION}.tar.gz
RUN cd /usr/src/ && tar xf sudo*
RUN cd /usr/src/sudo* \
    && ./configure \
    --prefix=/usr \
    --libexecdir=/usr/lib \
    --mandir=/usr/share/man \
    --disable-nls \
    --enable-pie \
    --without-env-editor \
    --without-pam \
    --without-skey \
    --with-passprompt="[sudo] password for %p: " \
    && make

RUN cd /usr/src/sudo* \
    && make install
