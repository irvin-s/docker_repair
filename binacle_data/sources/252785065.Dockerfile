FROM coding4m/dnswall  
MAINTAINER coding4m@gmail.com  
  
  
ENV DNSWALL_ADDR '0.0.0.0:53'  
ENV DNSWALL_BACKEND ''  
ENV DNSWALL_SERVERS '119.29.29.29:53,114.114.114.114:53'  
ENV DNSWALL_PATTERNS ''  
EXPOSE 53/udp 53/tcp  
ENTRYPOINT ["/usr/local/bin/dnswall-daemon"]

