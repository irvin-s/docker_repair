FROM clover/base AS base  
  
RUN groupadd \  
\--gid 50 \  
\--system \  
redis \  
&& useradd \  
\--home-dir /var/lib/redis \  
\--no-create-home \  
\--system \  
\--shell /bin/false \  
\--uid 50 \  
\--gid 50 \  
redis  
  
FROM library/ubuntu:bionic AS build  
  
ENV LANG=C.UTF-8  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& apt-get update \  
&& apt-get install -y \  
software-properties-common \  
apt-utils  
  
RUN mkdir -p /build /rootfs  
WORKDIR /build  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& apt-get download \  
redis-sentinel \  
redis-server \  
redis-tools \  
libjemalloc1  
RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs  
  
WORKDIR /rootfs  
RUN mkdir -p \  
var/lib/redis \  
run/redis \  
&& rm -rf \  
etc/default \  
etc/init.d \  
etc/logrotate.d \  
etc/redis/*.d \  
lib \  
usr/lib/tmpfiles.d \  
usr/share \  
&& sed -i -r \  
-e 's,^ *logfile +.*,logfile "",g' \  
-e 's,^ *daemonize +yes,daemonize no,g' \  
etc/redis/redis.conf \  
&& sed -i -r \  
-e 's,^ *logfile +.*,logfile "",g' \  
-e 's,^ *daemonize +yes,daemonize no,g' \  
etc/redis/sentinel.conf  
  
COPY \--from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/  
COPY init.sh etc/  
  
WORKDIR /  
  
FROM clover/common  
  
ENV LANG=C.UTF-8  
COPY \--from=build /rootfs /  
  
VOLUME ["/var/lib/redis"]  
  
CMD ["sh", "/etc/init.sh"]  
  
EXPOSE 6379  

