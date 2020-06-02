FROM alpine:latest  
LABEL maintainer "Dmitrii Ageev <d.ageev@gmail.com>"  
  
RUN apk --no-cache add dnsmasq  
  
VOLUME /etc/dnsmasq.d  
  
ADD files/dnsmasq.conf /etc/dnsmasq.conf  
ADD files/resolv.conf /etc/dnsmasq.d/resolv.conf  
ADD files/hosts /etc/dnsmasq.d/hosts  
ADD files/start.sh /start.sh  
  
EXPOSE 5353/udp  
ENTRYPOINT ["/start.sh"]  

