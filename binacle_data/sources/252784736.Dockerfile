FROM alpine:3.5  
RUN apk --update add coreutils  
  
WORKDIR /shredder/  
COPY bin/shredder /shredder/bin/shredder  
  
ENTRYPOINT ["/shredder/bin/shredder"]  

