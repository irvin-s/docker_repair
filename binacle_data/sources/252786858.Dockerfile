FROM alpine:3.4  
  
ENV FREERADIUS_VERSION=v3.0.x  
  
RUN \  
apk --update add \  
openssl-dev mariadb-dev postgresql-dev gdbm-dev readline-dev \  
bash libtool autoconf automake perl-dev python-dev openldap-dev krb5-dev \  
unixodbc-dev linux-pam-dev sqlite-dev talloc-dev libpcap-dev \  
linux-headers curl-dev hiredis-dev json-c-dev \  
net-snmp-tools \  
talloc \  
ruby-dev \  
openssl \  
&& apk add --virtual .build-dependencies \  
git \  
build-base \  
automake \  
&& git clone --depth 1 --single-branch -b $FREERADIUS_VERSION \  
https://github.com/FreeRADIUS/freeradius-server.git \  
&& cd freeradius-server \  
&& ln -s /usr/include/json-c json \  
&& ./configure \  
--build=$CBUILD \  
--host=$CHOST \  
--prefix=/usr \  
--sysconfdir=/etc \  
--mandir=/usr/share/man \  
--infodir=/usr/share/info \  
--localstatedir=/var \  
--datarootdir=/usr/share \  
--libdir=/usr/lib/freeradius \  
--with-logdir=/var/log/radius \  
--with-radacctdir=/var/log/radius/radacct \  
--with-system-libtool \  
--with-system-libltdl \  
--with-shared-libs \  
--with-udpfromto \  
--with-rlm_sql_sqlite \  
--with-rlm_sql_postgresql \  
--with-rlm_sql_mysql \  
--with-rlm_krb5 \  
--with-rlm_rest \  
--with-rlm_redis \  
--with-rlm_perl \  
--with-rlm_python \  
--with-rlm_ruby \  
--with-rlm_rediswho \  
--without-rlm_cassandra \  
--without-rlm_eap_tnc \  
--without-rlm_eap_ikev2 \  
--without-rlm_sql_iodbc \  
--without-rlm_sql_oracle \  
--without-rlm_yubikey \  
--without-rlm_ykclient \  
--with-jsonc-include-dir="$PWD" \  
&& make \  
&& make install \  
&& cd - \  
&& rm -rf /freeradius-server \  
&& apk del .build-dependencies  
  
CMD ["radiusd", "-X"]  

