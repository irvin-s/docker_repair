FROM jenkins:latest  
MAINTAINER Adam Burnett <adam.burnett@dealer.com>  
  
ENV DOCKER_VERSION 1.7.0  
ENV DOCKER_HOST unix:///var/run/docker.sock  
ENV DOCKER_OPTS ""  
USER root  
  
ADD install-docker.sh /tmp/install-docker.sh  
ADD docker /tmp/docker  
  
# sync - https://github.com/docker/docker/issues/9547  
RUN chmod +x /tmp/install-docker.sh && sync && \  
/tmp/install-docker.sh && \  
usermod -a -G docker jenkins && \  
mv /usr/bin/docker /usr/bin/docker-exec && \  
mv /tmp/docker /usr/bin/docker && \  
chmod +x /usr/bin/docker && \  
rm /tmp/install-docker.sh  
  
#USER jenkins  

