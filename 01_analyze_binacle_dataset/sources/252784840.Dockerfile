FROM debian  
MAINTAINER Josh VanderLinden <codekoala@gmail.com>  
  
RUN apt-get update && \  
apt-get install -y \  
dialog openvpn openssh-server runit \  
git-core git-flow curl vim-nox && \  
apt-get clean  
  
ADD sv/sshd/ /etc/sv/sshd/  
ADD sv/openvpn/ /etc/sv/openvpn/  
RUN chown -R root:root /etc/sv/* && \  
mkdir -p /var/run/sshd && \  
mkdir -p /var/run/openvpn && \  
ln -s /etc/sv/* /etc/service/  
  
CMD ["/usr/sbin/runsvdir-start"]  

