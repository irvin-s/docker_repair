FROM antoinebaudrand/blinux  
  
RUN zypper -n install git openssh wget curl  
RUN /usr/bin/ssh-keygen -A  
  
RUN useradd jenkins && \  
mkdir -p /home/jenkins && \  
chown jenkins /home/jenkins && \  
echo "jenkins:jenkins" | chpasswd  
  
EXPOSE 22  

