FROM cybe/ps-base:alpine37  
  
RUN apk --no-cache add murmur \  
&& deluser murmur \  
&& adduser -h /murmur -s /bin/sh -D murmur  
  
COPY murmur.ini /etc/murmur.ini  
  
USER murmur  
  
CMD ["murmurd", "-fg", "-ini", "/etc/murmur.ini"]  

