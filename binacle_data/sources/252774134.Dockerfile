FROM amarkwalder/cdk-base:0.1.0  
RUN apk add --update openntpd && \  
rm -rf /var/cache/apk/*  
  
ENTRYPOINT [ "ntpd", "-d", "-f", "/etc/ntpd.conf", "-s" ]  

