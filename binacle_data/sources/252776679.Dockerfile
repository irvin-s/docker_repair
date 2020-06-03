FROM alpine:3.7  
RUN apk --no-cache add libuv-dev libstdc++  
COPY hgfsclient /usr/bin/  
CMD ["hgfsclient"]  

