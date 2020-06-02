FROM strato-build

ENV VERSION 7.3p1
ENV LDFLAGS -s
RUN wget -P /usr/src/ http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-${VERSION}.tar.gz
RUN cd /usr/src && tar xf openssh*
RUN cd /usr/src/openssh* \
    && ./configure \
    --prefix=/usr \
    --sysconfdir=/etc/ssh \
    --datadir=/usr/share/openssh \
    --libexecdir=/usr/lib/ssh \
    --mandir=/usr/share/man \
    --with-pid-dir=/run \
    --with-mantype=man \
    --with-ldflags="${LDFLAGS}" \
    --disable-strip \
    --disable-lastlog \
    --disable-wtmp \
    --with-privsep-path=/var/empty \
    --with-privsep-user=sshd \
    --with-md5-passwords \
    --with-ssl-engine \
    --without-pam \
    && make

RUN cd /usr/src/openssh* \
    && make install
