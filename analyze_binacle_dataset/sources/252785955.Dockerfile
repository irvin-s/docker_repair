FROM bitnami/minideb:stretch as builder  
  
WORKDIR /opt/bats/  
  
ADD source/ .  
  
RUN ./install.sh /usr/local  
  
CMD ["/usr/local/bin/bats"]  

