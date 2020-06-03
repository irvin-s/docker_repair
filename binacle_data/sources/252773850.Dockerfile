FROM alpine:latest  
  
  
RUN apk add --no-cache py-pip ca-certificates && pip install s3cmd  
  
ENTRYPOINT ["s3cmd"]  
CMD ["--help"]  

