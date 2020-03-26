  
FROM alpine:3.5  
MAINTAINER "Colin Morelli" <colin@parakeet.is>  
  
RUN apk add --update rsyslog rsyslog-tls && rm -rf /var/cache/apk/*  
  
ADD run.sh /tmp/run.sh  
RUN chmod +x /tmp/run.sh  
ADD rsyslog.conf /etc/  
ADD ld-root-ca.crt /etc/rsyslog.d/keys/ca.d/  
  
EXPOSE 514  
EXPOSE 514/udp  
  
CMD ["sh", "-c", "/tmp/run.sh"]

