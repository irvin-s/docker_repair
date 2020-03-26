FROM ajoergensen/baseimage-alpine  
  
MAINTAINER ajoergensen  
  
RUN \  
apk add \--update git python && \  
apk add \--virtual build-dependencies make asciidoc python-dev xmlto && \  
cd /tmp && \  
git clone https://gitlab.com/esr/irker.git && \  
cd irker && \  
make && make install && \  
apk del build-dependencies && \  
rm -rf /var/cache/apk/* /tmp/*  
  
ADD root/ /  
  
RUN \  
chmod -v +x /etc/services.d/*/run  

