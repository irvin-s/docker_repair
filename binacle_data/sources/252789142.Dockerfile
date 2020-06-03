FROM alpine  
  
RUN apk --update add rsyslog && \  
rm -rf /var/cache/apk/*  
  
ENTRYPOINT ["rsyslogd", "-n"]  

