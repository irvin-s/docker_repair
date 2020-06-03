FROM alpine:3.4  
RUN apk update && apk add ca-certificates  
ADD client-proxy/build/client-proxy /client-proxy  
  
EXPOSE 2375  
ENTRYPOINT ["/client-proxy"]  

