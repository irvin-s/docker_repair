FROM jenkins:2.7.4  
USER root  
RUN apt-get update -qq && \  
apt-get install -y sudo apt-transport-https && \  
apt-get -y -qq install vim less rsync && \  
curl -fsSL get.docker.com | sudo bash &&\  
  
  
usermod -aG docker jenkins && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

