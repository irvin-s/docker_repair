FROM alpine  
RUN apk add --update nfs-utils  
ADD ./entry.sh /etc/init.d/entry.sh  
RUN chmod +x /etc/init.d/entry.sh  
ADD ./entry.sh /daemon.sh  
RUN chmod +x /daemon.sh  
  
ENTRYPOINT ["/daemon.sh" ]  

