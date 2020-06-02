# use edge image for higher client versions  
FROM alpine:edge  
  
MAINTAINER Benjamin Böhmke <benjamin@boehmke.net>  
  
RUN apk add --no-cache mysql-client postgresql-client  
  
ADD entrypoint.sh /entrypoint.sh  
  
VOLUME /backup/  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["app:init"]  

