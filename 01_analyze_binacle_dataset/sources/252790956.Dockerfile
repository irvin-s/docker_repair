FROM centos:latest  
  
MAINTAINER frodriguezd@gmail.com  
  
RUN yum update -y && yum -y install dnsmasq  
  
RUN rm -f /etc/dnsmasq.conf  
COPY etc/dnsmasq.conf /etc/  
COPY etc/resolv.dnsmasq.conf /etc/  
  
VOLUME /dnsmasq/  
  
EXPOSE 5353  
ENTRYPOINT ["/usr/sbin/dnsmasq", "-d"]  

