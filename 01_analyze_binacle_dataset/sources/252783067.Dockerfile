FROM alpine:3.6  
RUN apk --update add curl jq  
  
ADD config-validator.sh /config-validator.sh  
ADD empty.json /desired.json  
  
ENTRYPOINT /config-validator.sh  

