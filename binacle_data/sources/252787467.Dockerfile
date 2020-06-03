FROM alpine:3.4  
  
COPY build/dist/gcsfuse /usr/local/bin  
RUN chmod +x /usr/local/bin/gcsfuse  
  
RUN apk update && apk upgrade && \  
apk add \--no-cache fuse

