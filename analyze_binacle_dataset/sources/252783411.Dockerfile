FROM alpine:3.1  
RUN apk -U add curl && rm -f /var/cache/apk/*  
  
ENTRYPOINT ["curl", "-sSk"]  
  
CMD ["-h"]  

