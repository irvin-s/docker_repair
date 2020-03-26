FROM alpine  
RUN apk add links --no-cache  
ENTRYPOINT ["/usr/bin/links"]  

