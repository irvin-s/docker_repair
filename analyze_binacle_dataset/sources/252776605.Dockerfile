From ubuntu:precise  
MAINTAINER Elliott Ye  
  
# Set noninteractive mode for apt-get  
ENV DEBIAN_FRONTEND noninteractive  
  
# Upgrade base system packages  
RUN apt-get update  
  
### Start editing ###  
# Install package here for cache  
RUN apt-get -y install python-software-properties \  
&& add-apt-repository ppa:dlundquist/sniproxy \  
&& apt-get update && apt-get -y install sniproxy  
  
# Run  
CMD ["/usr/sbin/sniproxy","-f","-c","/etc/sniproxy/sniproxy.conf"]  

