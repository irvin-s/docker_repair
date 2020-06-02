FROM strato-build
RUN strato add xz-dev

ENV VERSION 2.29
ENV LDFLAGS -s
RUN wget -P /usr/src/ https://www.kernel.org/pub/linux/utils/util-linux/v${VERSION}/util-linux-${VERSION}.tar.gz
RUN cd /usr/src/ && tar xf util-linux*
RUN cd /usr/src/util-linux* \
    && ./configure \
    --prefix=/usr \
    --without-python \
    --without-systemdsystemunitdir \
    --disable-uuidd \
    --disable-nls \
    --disable-tls \
    --disable-kill \
    --disable-login \
    --disable-last \
    --disable-sulogin \
    --disable-su \
    && make

RUN cd /usr/src/util-linux* \
    && make install
