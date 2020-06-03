FROM strato-build

ENV LDFLAGS -s
RUN wget -P /usr/src/ http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/ntp-4.2.8p9.tar.gz
COPY ntp.conf config.guess config.sub /usr/src/
RUN cd /usr/src/ \
    && tar xf ntp*.tar.gz \
    && cd ntp* \
    && cp ../config.guess ../config.sub sntp/libevent/build-aux
RUN cd /usr/src/ntp* \
    && ./configure \
    --prefix=/usr \
    --bindir=/usr/sbin \
    && make

RUN cd /usr/src/ntp* \
    && make install \
    && install -m644 -D /usr/src/ntp.conf /etc/ntp.conf
