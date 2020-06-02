FROM alpine:latest  
  
MAINTAINER Brendan Johan Lee <deadcyclo@vanntett.net>  
  
RUN \  
apk --update add bash build-base openssh sshpass wget && \  
rm /var/cache/apk/*  
  
RUN \  
cd /tmp && \  
wget http://www.harding.motd.ca/autossh/autossh-1.4e.tgz && \  
tar -xzf autossh-*.tgz && \  
cd autossh-* && \  
./configure && \  
make && \  
make install && \  
cd .. && \  
rm -rf autossh-*  
  
WORKDIR /root  
  
COPY entrypoint.sh /entrypoint  
COPY tunnel.sh /usr/local/bin/tunnel  
COPY sshd.sh /usr/local/bin/sshd  
  
ENTRYPOINT ["/entrypoint"]  
  
EXPOSE 2222

