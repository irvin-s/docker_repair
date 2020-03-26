FROM alpine:3.7  
LABEL maintainer="dan.turner@cba.com.au"  
  
RUN apk add --no-cache stunnel  
  
WORKDIR /etc/stunnel/  
VOLUME /etc/stunnel/  
  
CMD ["stunnel"]  

