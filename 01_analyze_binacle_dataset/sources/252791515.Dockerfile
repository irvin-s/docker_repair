FROM daewood/abase  
MAINTAINER daewood <daewood@qq.com>  
  
RUN apk add --update rsyslog && \  
rm -rf /var/cache/apk/*  
  
ENTRYPOINT ["/init"]  
CMD []  
  
EXPOSE 514 514/udp  
VOLUME ["/var/log"]  

