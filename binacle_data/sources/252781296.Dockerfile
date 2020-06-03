FROM alpine:3.6  
RUN apk update; apk add git  
  
ADD entrypoint.sh /  
ENTRYPOINT ["/entrypoint.sh"]  

