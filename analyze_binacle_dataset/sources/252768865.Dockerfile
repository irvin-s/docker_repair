FROM alpine:latest  
  
MAINTAINER Andy Nicholson <andrew@anicholson.net>  
  
RUN apk update  
RUN apk add nodejs && npm install -g elm  
  
ENTRYPOINT ash  

