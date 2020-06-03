FROM clover/base AS base  
  
RUN groupadd \  
\--gid 50 \  
\--system \  
mysql \  
&& useradd \  
\--home-dir /var/lib/mysql \  
\--no-create-home \  
\--system \  
\--shell /bin/false \  
\--uid 50 \  
\--gid 50 \  
mysql  
  
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
libaio1 \  
liblz4-1 \  
libnuma1 \  
libstdc++6 \  
libwrap0 \  
mysql-server-5.7 \  
mysql-server-core-5.7  
RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs  
  
WORKDIR /rootfs  
RUN rm -rf \  
etc/apparmor.d \  
etc/init \  
etc/init.d \  
etc/logcheck \  
etc/logrotate.d \  
etc/mysql/* \  
lib/systemd \  
usr/bin \  
usr/share/apport \  
usr/share/doc \  
usr/share/gcc-5 \  
usr/share/gdb \  
usr/share/lintian \  
usr/share/man \  
usr/share/mysql/docs \  
usr/share/mysql/*.sql \  
usr/share/mysql/*.txt \  
usr/share/mysql/echo_stderr \  
usr/share/mysql/magic \  
usr/share/mysql/mysql-log-rotate \  
usr/share/mysql/mysql-systemd-start \  
usr/share/mysql/mysqld_multi.server \  
var/lib/mysql-upgrade \  
&& mkdir -p \  
etc/mysql/conf.d \  
var/run/mysqld \  
var/lib/mysql \  
var/lib/mysql-files \  
&& chmod 0770 var/lib/mysql-files  
  
COPY --from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/  
COPY my.cnf etc/mysql/  
COPY conf.d/ etc/mysql/conf.d/  
COPY init.sh etc/  
COPY init.sql usr/share/mysql/  
  
WORKDIR /  
  
  
FROM clover/common  
  
ENV LANG=C.UTF-8  
  
COPY --from=build /rootfs /  
  
VOLUME ["/var/lib/mysql"]  
  
CMD ["sh", "/etc/init.sh"]  
  
EXPOSE 3306  

