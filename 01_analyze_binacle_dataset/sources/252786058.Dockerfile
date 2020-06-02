FROM jenkins/jenkins  
  
USER root  
  
RUN apt-get update \  
&& apt-get install -y sudo \  
&& rm -rf /var/lib/apt/lists/* \  
&& curl -fsSL get.docker.com -o get-docker.sh \  
&& sh get-docker.sh \  
&& echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers  
  
USER jenkins  
  
COPY plugins.txt /usr/share/jenkins/plugins.txt  
  
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt  

