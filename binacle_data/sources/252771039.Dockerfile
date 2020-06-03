FROM gliderlabs/alpine:3.4  
RUN apk add bash docker --no-cache  
  
COPY ./docker-gc /docker-gc  
  
VOLUME /var/lib/docker-gc  
  
CMD ["/docker-gc"]  

