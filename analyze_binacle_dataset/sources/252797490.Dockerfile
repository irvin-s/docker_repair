FROM ubuntu:16.04  
COPY debug-mode.sh /root  
  
RUN \  
uptime  
  
ENTRYPOINT ["/usr/bin/uptime"]  
CMD ["-V"]  

