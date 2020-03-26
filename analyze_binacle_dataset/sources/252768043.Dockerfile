FROM alpine  
RUN apk add openssh mc --no-cache  
ENTRYPOINT ["/usr/bin/mc"]  

