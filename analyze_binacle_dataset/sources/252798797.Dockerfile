FROM alpine:3.7  
RUN apk --no-cache add libuv-dev  
COPY LEAF /usr/bin/  
ENTRYPOINT ["LEAF"]  

