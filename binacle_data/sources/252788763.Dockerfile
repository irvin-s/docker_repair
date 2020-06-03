FROM alpine:3.2  
RUN apk update && \  
apk upgrade && \  
apk add vim && \  
rm -rf /var/cache/apk/*  
  
ENTRYPOINT ["/usr/bin/vim"]  
CMD ["--help"]

