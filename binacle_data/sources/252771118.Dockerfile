FROM alpine:latest  
MAINTAINER Robert Jones <ahrotahntee@live.com>  
ENV TINC_NETWORK_NAME="automatic-tinc"  
ENV TINC_NETWORK_SUBNET="172.16.0.0/12"  
EXPOSE 655/udp 655/tcp  
RUN apk update && apk add tinc jq curl bind-tools && rm -rf /var/cache  
COPY entrypoint.sh /usr/sbin  
ENTRYPOINT ["/usr/sbin/entrypoint.sh"]  

