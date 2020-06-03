FROM strato-build

ENV VERSION 1.16
ENV LDFLAGS -s
RUN wget -P /usr/src/ http://rpm5.org/files/popt/popt-${VERSION}.tar.gz
RUN cd /usr/src/ && tar xf popt*
RUN cd /usr/src/popt* \
    && ./configure \
    --prefix=/usr \
    --libdir=/lib \
    --disable-static \
    && make

RUN cd /usr/src/popt* \
    && make install
