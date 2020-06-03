FROM alpine  
MAINTAINER b3vis  
RUN apk --no-cache add --virtual oxidized-runtime \  
ruby git libssh2 sqlite-libs libressl \  
&& apk --no-cache add --virtual oxidized-build-deps \  
ruby-dev cmake make libssh2-dev g++ sqlite-dev libressl-dev \  
&& gem install \  
\--no-ri \  
\--no-rdoc \  
json \  
aws-sdk \  
slack-api \  
oxidized \  
oxidized-script \  
oxidized-web \  
&& apk --no-cache del oxidized-build-deps  
RUN mkdir -p /root/.config /etc/oxidized /var/run/oxidized /var/lib/oxidized \  
&& ln -sf /etc/oxidized /root/.config/oxidized  
VOLUME ["/etc/oxidized", "/var/run/oxidized", "/var/lib/oxidized"]  
EXPOSE 8888/tcp  
ENTRYPOINT ["/usr/bin/oxidized"]  

