FROM alpine:3.6  
RUN apk add --update certbot && \  
rm -rf /apk /tmp/* /var/cache/apk/*  
  
CMD ["certbot","--help"]  

