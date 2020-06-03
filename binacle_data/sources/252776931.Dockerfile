FROM ubuntu:14.04  
  
COPY *.deb /root/  
RUN dpkg -i /root/*.deb; exit 0  
  
ENTRYPOINT ["/usr/bin/wmic"]  

