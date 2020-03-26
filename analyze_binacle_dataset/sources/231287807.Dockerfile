FROM strato-build

ENV VERSION 2.2.52
ENV LDFLAGS -s
RUN wget -P /usr/src/ http://download.savannah.gnu.org/releases/acl/acl-${VERSION}.src.tar.gz
RUN cd /usr/src/ && tar xf acl*
RUN cd /usr/src/acl* \
    && ./configure \
    --prefix=/usr \
    --libdir=/lib \
    --libexecdir=/usr/lib \
    --disable-gettext \
    && make

RUN cd /usr/src/acl* \
    && make install install-lib install-dev
