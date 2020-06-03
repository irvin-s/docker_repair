FROM strato-build

ENV LDFLAGS -s
RUN wget -P /usr/src/ http://zlib.net/zlib-1.2.11.tar.gz
RUN cd /usr/src/ && tar xf zlib*
RUN cd /usr/src/zlib* \
    && ./configure \
    --prefix=/usr \
    --libdir=/lib \
    --shared \
    && make

RUN cd /usr/src/zlib* \
    && make install
