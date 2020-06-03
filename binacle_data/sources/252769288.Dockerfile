FROM alpine:3.4  
RUN apk --update add gcc \  
libc-dev \  
pkgconfig \  
zeromq-dev  
  
ADD ./config/start.sh /home/  
  
RUN chmod u+x /home/start.sh  
  
CMD ["/home/start.sh"]  

