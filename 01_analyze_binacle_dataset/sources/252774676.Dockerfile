FROM debian  
MAINTAINER Ye Liu <yeliu@basecase.co>  
COPY start.sh /opt/start.sh  
RUN \  
apt-get update -y && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y postfix && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* && \  
ln -sf /etc/services /var/spool/postfix/etc/services && \  
postconf myhostname={{.Hostname}} && \  
postconf -X mydestination && \  
postconf virtual_alias_domains={{.Domains}} && \  
postconf virtual_alias_maps=hash:/etc/postfix/virtual && \  
postconf -F smtp/unix/chroot=n  
EXPOSE 25  
ENTRYPOINT ["/bin/bash", "/opt/start.sh"]  
  

