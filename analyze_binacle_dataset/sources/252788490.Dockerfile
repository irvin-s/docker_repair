FROM crux:latest  
MAINTAINER James Mills <prologic@shortcircuitnet.au>  
  
VOLUME /var/lib/docker  
  
CMD ["wrapdocker"]  
  
RUN curl -# -q -o /usr/bin/docker \  
https://get.docker.com/builds/Linux/x86_64/docker-latest && \  
chmod +x /usr/bin/docker  
  
ADD wrapdocker /usr/bin/wrapdocker  

