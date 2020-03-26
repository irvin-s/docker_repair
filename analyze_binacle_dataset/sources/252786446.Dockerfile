FROM alpine:3.4  
RUN apk update && apk add ca-certificates  
ADD server-proxy/build/server-proxy /server-proxy  
  
EXPOSE 2376  
ENTRYPOINT ["/server-proxy"]

