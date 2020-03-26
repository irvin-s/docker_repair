FROM alpine:edge  
MAINTAINER kevineye@gmail.com  
  
RUN apk -U add \  
git \  
build-base \  
autoconf \  
automake \  
libtool \  
alsa-lib-dev \  
libdaemon-dev \  
popt-dev \  
libressl-dev \  
soxr-dev \  
avahi-dev \  
libconfig-dev \  
  
&& cd /root \  
&& git clone https://github.com/mikebrady/shairport-sync.git \  
&& cd shairport-sync \  
  
&& autoreconf -i -f \  
&& ./configure \  
\--with-alsa \  
\--with-pipe \  
\--with-avahi \  
\--with-ssl=openssl \  
\--with-soxr \  
\--with-metadata \  
&& make \  
&& make install \  
  
&& cd / \  
&& apk --purge del \  
git \  
build-base \  
autoconf \  
automake \  
libtool \  
alsa-lib-dev \  
libdaemon-dev \  
popt-dev \  
libressl-dev \  
soxr-dev \  
avahi-dev \  
libconfig-dev \  
&& apk add \  
dbus \  
alsa-lib \  
libdaemon \  
popt \  
libressl \  
soxr \  
avahi \  
libconfig \  
python \  
&& rm -rf \  
/etc/ssl \  
/var/cache/apk/* \  
/lib/apk/db/* \  
/root/shairport-sync \  
&& mkfifo /pipe  
  
COPY start.sh /start  
COPY socket_clt.py /socket_clt.py  
  
ENV AIRPLAY_NAME Docker  
ENV REMOTE_HOST 192.168.10.53  
  
ENTRYPOINT [ "/start" ]  

