# version 1.6.5-3  
# docker-version 1.13.0  
FROM alpine:3.5  
MAINTAINER Chris Merrett "chris@chrismerrett.com"  
  
ARG ZNC_VERSION="1.6.5"  
  
# install build packages  
RUN \  
apk add --no-cache --virtual=build-dependencies \  
autoconf \  
automake \  
c-ares-dev \  
curl \  
cyrus-sasl-dev \  
g++ \  
gcc \  
gettext-dev \  
git \  
icu-dev \  
make \  
openssl-dev \  
perl-dev \  
python3-dev \  
swig \  
tar \  
tcl-dev && \  
  
# fetch and unpack source  
mkdir -p \  
/tmp/znc && \  
curl -o \  
/tmp/znc-src.tar.gz -L \  
"http://znc.in/releases/archive/znc-${ZNC_VERSION}.tar.gz" && \  
tar xf \  
/tmp/znc-src.tar.gz -C \  
/tmp/znc --strip-components=1 && \  
  
# configure and compile znc  
cd /tmp/znc && \  
export CFLAGS="$CFLAGS -D_GNU_SOURCE" && \  
./configure \  
\--build=$CBUILD \  
\--enable-cyrus \  
\--enable-perl \  
\--enable-python \  
\--enable-swig \  
\--enable-tcl \  
\--host=$CHOST \  
\--infodir=/usr/share/info \  
\--localstatedir=/var \  
\--mandir=/usr/share/man \  
\--prefix=/usr \  
\--sysconfdir=/etc && \  
make && \  
make install && \  
  
# determine build packages to keep  
RUNTIME_PACKAGES="$( \  
scanelf --needed --nobanner /usr/bin/znc \  
| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \  
| sort -u \  
| xargs -r apk info --installed \  
| sort -u \  
)" && \  
apk add --no-cache \  
${RUNTIME_PACKAGES} \  
bash \  
ca-certificates \  
g++ \  
gcc \  
icu-dev \  
openssl \  
openssl-dev \  
sudo && \  
  
# cleanup  
apk del --purge \  
build-dependencies && \  
rm -rf \  
/tmp/*  
  
RUN adduser -D znc  
ADD docker-entrypoint.sh /entrypoint.sh  
ADD znc.conf.default /znc.conf.default  
RUN chmod 644 /znc.conf.default  
  
VOLUME /znc-data  
  
EXPOSE 6667  
ENTRYPOINT ["/entrypoint.sh"]  
CMD [""]  

