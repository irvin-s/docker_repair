# FROM debian:7  
FROM alpine  
MAINTAINER Me <andreas.krey@aquilus.com>  
  
# RUN apt-get update && apt-get install -y tor net-tools  
RUN apk update && apk add tor  
  
RUN mkdir -p /app  
COPY t.sh torrc /app/  
RUN chmod 755 /app/t.sh  
  
CMD ["/app/t.sh"]  

