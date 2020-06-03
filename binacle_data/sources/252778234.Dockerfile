FROM alpine:3.5  
RUN apk --update --no-cache add bash rsync && \  
rm -rf /var/cache/apk/*  
  
ENTRYPOINT ["rsync"]  
CMD []  

