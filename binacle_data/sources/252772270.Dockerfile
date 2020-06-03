FROM alpine  
RUN apk add --update perl && rm -rf /var/cache/apk/*  
ENTRYPOINT ["/usr/bin/perl", "-de0"]  

