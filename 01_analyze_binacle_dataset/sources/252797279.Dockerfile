FROM clover/base AS base  
  
RUN groupadd \  
\--gid 50 \  
\--system \  
beanstalkd \  
&& useradd \  
\--home-dir /var/lib/beanstalkd \  
\--no-create-home \  
\--system \  
\--shell /bin/false \  
\--uid 50 \  
\--gid 50 \  
beanstalkd  
  
FROM library/ubuntu:bionic AS build  
  
ENV LANG=C.UTF-8  
  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& apt-get update \  
&& apt-get install -y \  
software-properties-common \  
apt-utils  
  
RUN mkdir -p /build /rootfs  
WORKDIR /build  
RUN apt-get download \  
beanstalkd \  
libsystemd0 \  
libgcrypt20 \  
liblz4-1 \  
liblzma5 \  
libgpg-error0  
RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs  
  
WORKDIR /rootfs  
RUN rm -rf \  
etc/default \  
etc/init.d \  
lib/systemd \  
usr/share  
  
COPY \--from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/  
COPY init.sh etc/  
  
WORKDIR /  
  
  
FROM clover/common  
  
ENV LANG=C.UTF-8  
  
COPY \--from=build /rootfs /  
  
VOLUME ["/var/lib/beanstalkd"]  
  
CMD ["sh", "/etc/init.sh"]  
  
EXPOSE 11300  

