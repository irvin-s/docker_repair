FROM strato-build

ENV VERSION 7.0
ENV LDFLAGS -s
RUN wget -P /usr/src/ https://ftp.gnu.org/gnu/readline/readline-${VERSION}.tar.gz
RUN cd /usr/src/ && tar xf readline*
RUN cd /usr/src/readline* \
    && ./configure \
    --prefix=/usr \
    --mandir=/usr/share/man \
    --infodir=/usr/share/info \
    --disable-static \
    --enable-shared \
    && make

RUN cd /usr/src/readline* \
    && make install
