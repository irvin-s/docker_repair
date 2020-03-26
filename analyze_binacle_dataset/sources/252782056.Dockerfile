FROM jenkins/jenkins:2.105-alpine  
  
MAINTAINER Rodrigo Floriano de Souza <florianocomercial@gmail.com>  
  
COPY plugins.txt /usr/share/jenkins/plugins.txt  
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt  
  
USER root  
  
ADD https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz /tmp  
RUN tar -xvzf /tmp/docker-latest.tgz && \  
mv docker/* /usr/bin/ && \  
chmod +x /usr/bin/docker && \  
rm -f /tmp/docker-latest.tgz  
  
RUN addgroup $USER docker  

