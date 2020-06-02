FROM colstrom/alpine  
ADD syslog.sh /usr/local/bin/syslog  
RUN chmod a+x /usr/local/bin/syslog  
  
EXPOSE 514/udp  
ENTRYPOINT ["syslog"]  

