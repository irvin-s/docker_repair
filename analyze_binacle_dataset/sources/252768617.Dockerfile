FROM debian  
MAINTAINER Cheng Jeng<s100062314@m100.nthu.edu.tw>  
ADD ./wrapdocker /usr/local/bin/wrapdocker  
RUN apt-get update && apt-get install -y \  
apparmor \  
apt-transport-https \  
ca-certificates \  
curl \  
lxc \  
iptables && \  
curl -sSL https://get.docker.com/ | sh && \  
chmod +x /usr/local/bin/wrapdocker  
VOLUME /var/lib/docker  
CMD ["wrapdocker"]  
  

