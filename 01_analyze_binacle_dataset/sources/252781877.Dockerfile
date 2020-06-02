FROM golang:1.5.2-wheezy  
  
MAINTAINER Christian Blades <christian.blades@careerbuilder.com>  
  
VOLUME /src  
WORKDIR /src  
  
ENTRYPOINT ["/build.sh"]  
  
ADD https://get.docker.com/builds/Linux/x86_64/docker-1.9.1 /usr/bin/docker  
RUN chmod +x /usr/bin/docker  
  
ADD build.sh /  

