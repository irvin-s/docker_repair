FROM alpine:3.4  
RUN apk update && apk add ca-certificates  
ADD client/build/client /client  
ADD https://files.cloud.docker.com/ca/ca.pem /ca.pem  
  
ENTRYPOINT ["/client"]  

