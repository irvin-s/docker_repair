FROM docker:18.03.1-ce-dind  
  
RUN mkdir /etc/docker  
ADD daemon-config.json /etc/docker/daemon.json  

