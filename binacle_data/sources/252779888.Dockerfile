FROM alpine:latest  
RUN apk update  
RUN apk add nfs-utils bash  
RUN rm -rf /var/cache/apk/*  
  
ADD ./entry.sh /entry.sh  
RUN chmod +x /entry.sh  
  
ENTRYPOINT ["/entry.sh" ]  

