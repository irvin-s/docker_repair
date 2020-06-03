FROM alpine:3.5  
MAINTAINER Brian Lachniet <blachniet@gmail.com>  
  
# Install root CA certificates  
RUN apk add --no-cache ca-certificates  
  
# Put the timezone database in the standard Go location  
COPY zoneinfo.zip /usr/local/go/lib/time/

