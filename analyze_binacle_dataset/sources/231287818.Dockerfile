FROM strato-build
RUN strato add xz-dev

ENV VERSION 4.3
ENV LDFLAGS -s
COPY fetch-patches /usr/bin/
RUN wget -P /usr/src/ https://ftp.gnu.org/gnu/bash/bash-${VERSION}.tar.gz
RUN cd /usr/src && tar xf bash*.tar.gz && fetch-patches
RUN cd /usr/src/bash* && for i in ../*.patch; do patch -p0 < ${i}; done
RUN cd /usr/src/bash* \
    && ./configure \
    --prefix=/usr \
    --bindir=/bin \
    --mandir=/usr/share/man \
    --infodir=/usr/share/info \
    --disable-nls \
    --enable-readline \
    --without-bash-malloc \
    && make

RUN cd /usr/src/bash* \
    && make install
