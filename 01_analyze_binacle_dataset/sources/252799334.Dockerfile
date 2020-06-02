FROM alpine:latest  
RUN apk update; apk add netcat-openbsd  
ENTRYPOINT ["/usr/bin/nc","-d","-l","0.0.0.0"]  
CMD ["80"]  
  

