FROM jenkins:latest  
MAINTAINER Simon Takite "simontakite@gmail.com"  
USER root  
RUN apt-get update \  
&& apt-get install -y sudo \  
&& rm -rf /var/lib/apt/lists/*  
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers  
USER jenkins  
  
COPY plugins.txt /var/jenkins_home/plugins.txt  
RUN /usr/local/bin/plugins.sh /var/jenkins_home/plugins.txt  

