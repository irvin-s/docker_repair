FROM alpine:3.5  
MAINTAINER de13 <stephane.beuret@data-essential.com>  
  
RUN apk upgrade && \  
apk --no-cache add dnsmasq  
  
COPY dnsmasq.conf /etc/dnsmasq.conf  
COPY addn_hosts /etc/addn_hosts  
COPY resolvers /etc/resolvers  
  
EXPOSE 53 53/udp  
  
ENTRYPOINT ["dnsmasq", "-k"]  

