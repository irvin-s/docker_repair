FROM alpine:3.6  
MAINTAINER Alexander Chumakov <ts.delfer@gmail.com>  
  
RUN apk --no-cache add vim \  
curl \  
bind-tools  

