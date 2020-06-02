FROM alpine:latest  
MAINTAINER atomney <atomney+docker@gmail.com>  
  
COPY openvpn.sh /usr/local/bin/openvpn.sh  
RUN apk add --no-cache openvpn && chmod +x /usr/local/bin/openvpn.sh  
COPY pia /pia  
WORKDIR /pia  
  
ENV REGION="US East"  
ENTRYPOINT ["openvpn.sh"]  

