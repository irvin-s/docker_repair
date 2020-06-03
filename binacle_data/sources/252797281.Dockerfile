FROM clover/base AS base  
  
RUN groupadd \  
\--gid 50 \  
\--system \  
certbot \  
&& useradd \  
\--home-dir /var/lib/letsencrypt \  
\--no-create-home \  
\--system \  
\--shell /bin/false \  
\--uid 50 \  
\--gid 50 \  
certbot  
  
FROM library/ubuntu:bionic AS build  
  
ENV LANG=C.UTF-8  
  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& apt-get update \  
&& apt-get install -y \  
software-properties-common \  
apt-utils  
  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& add-apt-repository -y ppa:certbot/certbot \  
&& apt-get update  
  
RUN mkdir -p /build /rootfs  
WORKDIR /build  
RUN apt-get download \  
python3-certbot \  
python3-acme \  
python3-requests \  
python3-certifi \  
python3-chardet \  
python3-idna \  
python3-urllib3 \  
python3-configargparse \  
python3-configobj \  
python3-cryptography \  
python3-asn1crypto \  
python3-josepy \  
python3-pkg-resources \  
python3-mock \  
python3-pbr \  
python3-openssl \  
python3-parsedatetime \  
python3-future \  
python3-rfc3339 \  
python3-six \  
python3-tz \  
python3-zope.component \  
python3-zope.hookable \  
python3-zope.event \  
python3-zope.interface \  
python3-cffi-backend \  
certbot  
RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs  
  
WORKDIR /rootfs  
RUN rm -rf \  
etc/cron* \  
etc/logrotate.d \  
lib/systemd \  
usr/share/doc \  
usr/share/lintian \  
usr/share/man \  
&& mkdir -p \  
www/.well-known/acme-challenge \  
var/log/letsencrypt \  
var/lib/letsencrypt \  
&& touch www/.well-known/acme-challenge/.keep  
  
COPY --from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/  
COPY certbot etc/cron.d/  
COPY init.sh etc/  
COPY cli.ini etc/letsencrypt/  
  
WORKDIR /  
  
  
FROM clover/python:3.6  
  
ENV LANG=C.UTF-8  
  
COPY --from=build /rootfs /  
  
VOLUME ["/etc/letsencrypt"]  
  
CMD ["sh", "/etc/init.sh"]  
  
EXPOSE 80 443  

