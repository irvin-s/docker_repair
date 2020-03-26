FROM alpine:3.3  
MAINTAINER Alexey Diyan <alexey.diyan@gmail.com>  
  
RUN set -x \  
&& buildDeps='go build-base geoip-dev ncurses-dev' \  
&& apk add --update geoip ncurses $buildDeps \  
&& wget -O /tmp/goaccess.tar.gz http://tar.goaccess.io/goaccess-0.9.7.tar.gz \  
&& tar -xzvf /tmp/goaccess.tar.gz -C /tmp \  
&& cd /tmp/goaccess-0.9.7 \  
&& ./configure --enable-geoip --enable-utf8 \  
&& make \  
&& make install \  
&& apk del $buildDeps \  
&& rm -rf /var/cache/apk/* /tmp/goaccess*  
  
ENTRYPOINT ["goaccess"]  

