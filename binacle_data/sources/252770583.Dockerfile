FROM alpine  
  
RUN apk add --no-cache jq  
  
# install asserts  
ADD assets/ /opt/resource/  
RUN chmod +x /opt/resource/*  

