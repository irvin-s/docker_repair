FROM alpine:3.6  
RUN apk add \--update \  
graphviz \  
&& rm -rf /var/cache/apk/*  
  

