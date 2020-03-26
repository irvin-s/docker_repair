FROM alpine:latest  
  
RUN apk --no-cache add lftp ca-certificates openssh  
  
ENTRYPOINT ["lftp"]  
CMD ["--help"]  

