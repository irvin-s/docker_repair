FROM cbwang/kcp-ssr-docker  
  
RUN apk update && apk add libnet-dev libpcap-dev git g++  
RUN git clone https://github.com/snooda/net-speeder.git net-speeder  
WORKDIR net-speeder  
RUN sh build.sh  
  
RUN mv net_speeder /usr/local/bin/  
  
ADD start.sh /netspeederstart.sh  
RUN chmod +x /netspeederstart.sh  
RUN chmod +x /usr/local/bin/net_speeder  
  
ENTRYPOINT ["/netspeederstart.sh"]  

