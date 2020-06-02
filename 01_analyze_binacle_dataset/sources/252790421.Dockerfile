############################################################  
# Dockerfile: CentOS6 & OpenVPN  
############################################################  
FROM centos:centos6  
  
MAINTAINER CarbonSphere <CarbonSphere@gmail.com>  
  
# Set environment variable  
ENV HOME /root  
ENV TERM xterm  
  
RUN yum -y update; yum -y install epel-release; yum -y clean all  
  
RUN yum -y install openvpn; yum -y clean all  
  
EXPOSE 1194/tcp  
  
ADD ovpn_start.sh /usr/local/bin/ovpn_start.sh  
ADD cp_example.sh /usr/local/bin/cp_example.sh  
ADD example /example  
  
ENV CPDIR /dest  
  
WORKDIR /etc/openvpn  
  
CMD ["ovpn_start.sh"]  

