FROM cloudposse/rsync  
  
MAINTAINER Erik Osterman "e@osterman.com"  
  
ENV RSYNC_USERNAME rsync  
ENV RSYNC_UID nobody  
ENV RSYNC_GID nogroup  
ENV RSYNC_ALLOW 10.0.0.0/8  
ENV RSYNC_VOLUME /vol  
ENV RSYNC_NAME vol  
ENV RSYNC_READ_ONLY false  
ENV RSYNC_TIMEOUT 300  
ENV RSYNC_MAX_CONNECTIONS 10  
ENV RSYNC_PORT 873  
  
EXPOSE $RSYNC_PORT  
ADD server /server  
  
RUN chmod 755 /server  
  
ENTRYPOINT ["/server"]  
  
  

