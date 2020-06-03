FROM ubuntu  
MAINTAINER Aaron Daniel aaron@ninjawarriors.io  
  
# original Dockerfile borrowed from moul/weechat  
# updated to use latest weechat and a single command for installation  
# to avoid the 42 layers issue  
RUN \  
apt-get -q -y update ;\  
apt-get install -y python-software-properties ;\  
add-apt-repository -y ppa:nesthib/weechat-stable ;\  
apt-get -q -y update ;\  
apt-get install -y openssh-server weechat tmux ;\  
mkdir /var/run/sshd ;\  
useradd -m docker -s /bin/bash  
  
EXPOSE 22  
ADD bashrc /home/docker/.bashrc  
ADD startup.sh /usr/bin/startup.sh  
  
RUN chmod 755 /usr/bin/startup.sh  
  
# The argument is the user as set up above  
CMD ["/usr/bin/startup.sh", "docker"]  

