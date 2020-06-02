FROM ubuntu:14.04  
MAINTAINER dockerizeit@1uptalent.com  
  
RUN apt-get update  
RUN apt-get install -y openssh-client  
  
ADD launch.sh /  
  
ENV TUNNEL_SERVER tunnels.dockerize.it  
ENV EXPOSE_PORT 8000  
CMD ./launch.sh  

