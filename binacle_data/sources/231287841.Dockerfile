FROM strato-build
RUN strato add xz-dev

ENV VERSION 0.12.1
ENV LDFLAGS -s
RUN wget -P /usr/src/ https://s3.amazonaws.com/json-c_releases/releases/json-c-${VERSION}.tar.gz
RUN cd /usr/src/ && tar xf json-c*
RUN cd /usr/src/json-c* \
    && ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --mandir=/usr/share/man \
    --infodir=/usr/share/info \
    --localstatedir=/var \
    --disable-static \
    --enable-shared \
    && make

RUN cd /usr/src/json-c* \
    && make install
