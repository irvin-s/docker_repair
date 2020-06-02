FROM alpine:3.3  
RUN apk add --no-cache mysql-client  
ENTRYPOINT ["mysql"]  

