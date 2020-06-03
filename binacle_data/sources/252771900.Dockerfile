FROM ubuntu:14.04  
  
MAINTAINER Robert Northard, <robert.a.northard>  
  
ENV NGINX_VERSION 1.8.0  
############## nginx setup ##############  
  
RUN apt-get update \  
&& apt-get install -y \  
ca-certificates \  
git \  
gcc \  
make \  
libpcre3-dev \  
zlib1g-dev \  
libldap2-dev \  
libssl-dev \  
wget \  
jq  
  
# See http://wiki.nginx.org/InstallOptions  
RUN mkdir /var/log/nginx \  
&& mkdir -p /etc/nginx/sites-enabled \  
&& cd ~ \  
&& git clone https://github.com/kvspb/nginx-auth-ldap.git \  
&& git clone https://github.com/nginx/nginx.git \  
&& cd nginx \  
&& git checkout tags/release-${NGINX_VERSION} \  
&& ./auto/configure \  
\--add-module=/root/nginx-auth-ldap \  
\--with-http_ssl_module \  
\--with-debug \  
\--conf-path=/etc/nginx/nginx.conf \  
\--sbin-path=/usr/sbin/nginx \  
\--pid-path=/var/run/nginx.pid \  
\--error-log-path=/var/log/nginx/error.log \  
\--http-log-path=/var/log/nginx/access.log \  
&& make install \  
&& cd .. \  
&& rm -rf nginx-auth-ldap \  
&& rm -rf nginx  
  
COPY templates/nginx/nginx.init /etc/init.d/nginx  
RUN chmod +x /etc/init.d/nginx  
  
EXPOSE 80 443  
# Adding base data  
RUN mkdir -p /resources/  
COPY resources/configuration/ /resources/configuration/  
COPY resources/release_note/ /resources/release_note/  
COPY resources/scripts/ /resources/scripts/  
COPY templates/configuration/ /templates/configuration/  
RUN chmod +x /resources/scripts/*  
  
CMD ["/resources/scripts/entrypoint.sh"]

