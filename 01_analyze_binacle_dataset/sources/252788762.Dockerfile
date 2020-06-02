FROM alpine:3.2  
# Update and install all of the required packages  
# At the end, remove the apk cache  
RUN apk update && \  
apk upgrade && \  
apk add nano && \  
rm -rf /var/cache/apk/*  
  
ENTRYPOINT ["/usr/bin/nano"]  
CMD ["--help"]

