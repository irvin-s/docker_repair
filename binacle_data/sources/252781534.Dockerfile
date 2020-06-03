FROM alpine:3.7  
ENV MYSQL_USER "root"  
ENV MYSQL_PASSWORD ""  
ENV VERBOSE false  
  
RUN apk update  
RUN apk add mysql-client  
ADD entrypoint.sh .  
  
ENTRYPOINT ["./entrypoint.sh"]

