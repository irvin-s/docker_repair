FROM alpine:3.4  
WORKDIR /unzip  
ENTRYPOINT ["unzip"]  
RUN apk add -U unzip && rm -rf /var/cache/apk/*  

