FROM alpine:3.4  
MAINTAINER dentych  
  
# Install ZNC.  
RUN apk add --no-cache \  
znc \  
znc-extra \  
znc-modperl \  
znc-modpython \  
znc-modtcl \  
ca-certificates \  
sudo  
# Create znc data directory.  
RUN mkdir /znc-data  
# Set permission on the znc-data dir.  
RUN chown -R znc:znc /znc-data  
# Add znc to sudoers file  
RUN echo "znc ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers  
  
ADD start.sh /start.sh  
  
USER znc  
  
WORKDIR /znc-data  
  
ENTRYPOINT ["/start.sh"]  
  
CMD ["--datadir=/znc-data", "--foreground"]  

