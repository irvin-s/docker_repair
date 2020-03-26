FROM lsiobase/alpine:3.7  
MAINTAINER aptalca  
  
# environment settings  
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2  
# install packages  
RUN \  
apk add --no-cache \  
logrotate \  
nano \  
perl-compress-raw-zlib \  
perl-gd \  
perl-html-parser \  
perl-http-cookies \  
perl-json \  
perl-json-maybexs \  
perl-lwp-protocol-https \  
perl-lwp-useragent-determined \  
wget && \  
apk add --no-cache \  
\--repository http://nl.alpinelinux.org/alpine/edge/testing \  
perl-json-xs && \  
  
# fix logrotate  
sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf  
# copy local files  
COPY root/ /  
  
# ports and volumes  
VOLUME /config  
  

