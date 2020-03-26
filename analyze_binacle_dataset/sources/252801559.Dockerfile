FROM alpine:3.7  
RUN apk --no-cache add haveged  
ENTRYPOINT ["haveged", "-F"]  

