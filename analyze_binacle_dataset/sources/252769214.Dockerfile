FROM python:3.6-alpine  
  
RUN set -xe \  
&& apk add \--no-cache \  
dialog \  
libffi \  
openssl  
  
ADD letsencrypt-auto-requirements.txt /usr/src  
RUN set -xe \  
&& apk add \--no-cache --virtual .build-deps \  
gcc \  
libc-dev \  
libffi-dev \  
openssl-dev \  
&& pip install --no-cache-dir --require-hashes \  
-r /usr/src/letsencrypt-auto-requirements.txt \  
&& apk del .build-deps  
  
RUN set -xe \  
&& addgroup -S certbot \  
&& adduser -S -D -H -G certbot -h /etc/letsencrypt -s /sbin/nologin certbot \  
&& install -d -o certbot -g certbot -m 0700 /etc/letsencrypt  
USER certbot  
  
ENTRYPOINT ["certbot"]  

