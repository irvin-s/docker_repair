FROM ubuntu:16.04  
#--------- SETUP GAME -----------  
RUN apt-get update && apt-get install -y \  
openssh-server \  
git \  
curl \  
vim \  
apt-utils \  
iputils-ping \  
sudo  
  
RUN apt-get remove -y --purge apache2  
  
#--------- SETUP System -----------  
# add user  
RUN useradd -ms /bin/bash -g sudo sysadmin  
RUN echo 'sysadmin:password' | chpasswd  
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers  
  
# Config SSH  
# Set SSH timeout to 10min (60sec*10)  
RUN mkdir /var/run/sshd  
#no timeout for local docker images  
#RUN echo 'ClientAliveInterval 60' >> /etc/ssh/sshd_config  
#RUN echo 'ClientAliveCountMax 10' >> /etc/ssh/sshd_config  
#RUN echo 'TCPKeepAlive no' >> /etc/ssh/sshd_config  
#--------- SETUP GAME -----------  
USER sysadmin  
WORKDIR /home/sysadmin/  
#Clone Repo  
RUN git clone 'https://github.com/admindojo/admindojo.git'  
WORKDIR /home/sysadmin/admindojo/  
RUN sudo bash /home/sysadmin/admindojo/setup.sh  
  
#------------- ROOT -------------  
USER root  
  
# Setup SSH  
EXPOSE 22  
CMD ["/usr/sbin/sshd", "-D"]  

