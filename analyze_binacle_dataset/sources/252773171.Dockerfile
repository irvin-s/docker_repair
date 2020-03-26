FROM alpine:3.6  
RUN apk add -U --no-cache freeradius freeradius-ldap  
COPY ./entrypoint.sh /entrypoint.sh  
  
EXPOSE 1812/udp  
  
ENTRYPOINT ["/entrypoint.sh"]  

