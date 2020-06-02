FROM deweysasser/docker-login  
  
RUN apk add --no-cache jq  
  
RUN mv /root/login.sh /root/base-login.sh  
ADD login.sh /root/

