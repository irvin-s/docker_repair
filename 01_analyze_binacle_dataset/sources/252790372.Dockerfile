FROM jenkins/jenkins:lts  
  
USER root  
  
RUN apt-get update &&\  
apt-get install -qy git apt-utils curl dpkg jq libexpat1-dev vim &&\  
apt-get install -f -qy &&\  
rm -rf /var/lib/apt/lists/* &&\  
apt-get install -f -qy &&\  
apt-get clean &&\  
rm -rf \  
/tmp/* \  
/var/lib/apt/lists/* \  
/var/tmp/*  
  
VOLUME /backup  
  
USER jenkins  
  
EXPOSE 8080 50000

