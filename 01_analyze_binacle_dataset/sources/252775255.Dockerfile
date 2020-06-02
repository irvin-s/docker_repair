FROM alpine:3.5  
RUN apk --no-cache update && \  
apk --no-cache add curl gzip && \  
rm -rf /var/cache/apk/*  
ENTRYPOINT ["curl"]  

