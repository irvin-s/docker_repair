FROM strato-build
RUN strato add xz-dev acl-dev popt-dev lvm2-dev json-c-dev libestr-dev

ENV VERSION 8.16.0
ENV LDFLAGS -s
RUN wget -P /usr/src/ http://www.rsyslog.com/files/download/rsyslog/rsyslog-${VERSION}.tar.gz
COPY rsyslog.conf /usr/src/
RUN cd /usr/src/ && tar xf rsyslog*.tar.gz
RUN cd /usr/src/rsyslog* \
    && ./configure \
    --prefix=/usr \
    --disable-rfc3195 \
    --enable-largefile \
    --disable-imdiag \
    --disable-imfile \
    --disable-mail \
    --disable-omprog \
    --disable-omstdout \
    --disable-omudpspoof \
    --disable-imptcp \
    --disable-impstats \
    --disable-mysql \
    --disable-pgsql \
    --disable-gnutls \
    --disable-snmp \
    --disable-omhiredis \
    --disable-libgcrypt \
    --disable-liblogging-stdlog \
    && make

RUN cd /usr/src/rsyslog* \
    && make install \
    && install -m644 -D /usr/src/rsyslog.conf /etc/rsyslog.conf
