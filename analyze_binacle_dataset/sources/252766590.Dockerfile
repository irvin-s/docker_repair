FROM alpine:3.6  
RUN apk add --no-cache rsyslog  
ADD rsyslog.conf /etc/rsyslog.conf  
  
EXPOSE 514 514/udp  
  
VOLUME ["/var/log"]  
  
ENTRYPOINT ["rsyslogd", "-n"]  

