  
FROM python:2-alpine  
MAINTAINER DylanWu  
  
VOLUME /etc/letsencrypt /var/lib/letsencrypt  
WORKDIR /opt/certbot  
  
COPY CHANGES.rst README.rst setup.py src/  
COPY acme src/acme  
COPY certbot src/certbot  
  
RUN apk add --no-cache --virtual .certbot-deps \  
libffi \  
libssl1.0 \  
ca-certificates \  
binutils  
RUN apk add --no-cache --virtual .build-deps \  
gcc \  
linux-headers \  
openssl-dev \  
musl-dev \  
libffi-dev \  
&& pip install --no-cache-dir \  
\--editable /opt/certbot/src/acme \  
\--editable /opt/certbot/src \  
&& apk del .build-deps  
  
COPY docker-entrypoint.sh /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  

