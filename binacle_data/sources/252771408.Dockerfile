FROM alpine  
RUN apk update  
RUN apk add iptables  
RUN apk add ip6tables  
RUN apk add iptables-doc  
RUN apk add iproute2  
RUN apk add drill  
RUN apk add iputils  
RUN apk add bash  
RUN apk add tcpdump  
RUN apk add dialog  
RUN apk add nano  
RUN apk add --update dnsmasq && rm -rf /var/cache/apk/*  
ADD nat.sh /data/nat.sh  
VOLUME /etc/dnsmasq  
VOLUME /data  

